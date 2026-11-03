# shellcheck shell=bash
#
# git-hide: make git stop reporting files, whatever their state.
#
#   committed  -> skip-worktree, so local edits are ignored
#   untracked  -> put pattern in .git/info/exclude
#   staged-new -> unstaged, then excluded

REGION_START='# git hide >>>'
REGION_END='# git hide <<<'

die() {
  echo "git-hide: $*" >&2
  exit 1
}

warn() {
  echo "git-hide: $*" >&2
}

usage() {
  cat >&2 <<'EOF'
usage: git-hide <command> [<args>]

  list                  list hidden files ("S path": skip-worktree, "X path": excluded)
  hide <path>...        hide file(s)
  unhide <path>...      unhide file(s)
  unhide-all            unhide everything
  stash [<args>]        git stash, including changes to hidden files
  unstash [<args>]      git stash pop, hiding the files it touches again
EOF
  exit 1
}

git_prefix=${GIT_PREFIX-$(git rev-parse --show-prefix)}
repo_root=$(git rev-parse --show-toplevel)
cd "$repo_root"

common_dir=$(git rev-parse --git-common-dir)
exclusions=$common_dir/info/exclude
records=$common_dir/hidden-stash

# rel <path>: repo-relative path of a user-supplied one
rel() {
  local p=$1
  [[ $p == /* ]] || p=$repo_root/$git_prefix$p
  p=$(realpath -sm --relative-to="$repo_root" -- "$p")

  if [[ $p == .. || $p == ../* ]]; then
    die "$1 is not part of the repository"
  fi

  printf '%s\n' "$p"
}

# NUL-separated paths of everything carrying the skip-worktree marker (S)
skip_worktree_paths() {
  git ls-files -v -z | awk -v RS='\0' -v ORS='\0' 'substr($0, 1, 2) == "S " { print substr($0, 3) }'
}

# Paths in git-hide's region of the exclude file, one per line
excluded_paths() {
  [[ -f $exclusions ]] || return 0
  awk -v s="$REGION_START" -v e="$REGION_END" '
    $0 == s { f = 1; next }
    $0 == e { f = 0 }
    f { sub(/^\//, ""); print }
  ' "$exclusions"
}

# Whether a path is in git-hide's region of the exclude file
is_excluded() {
  [[ -f $exclusions ]] || return 1

  P=/$1 awk -v s="$REGION_START" -v e="$REGION_END" '
    $0 == s { f = 1; next }
    $0 == e { f = 0 }
    f && $0 == ENVIRON["P"] { found = 1 }
    END { exit !found }
  ' "$exclusions"
}

# Adds a path to git-hide's region of the exclude file.
# Creates both the file and the region if they don't exist
add_exclude() {
  mkdir -p "$(dirname "$exclusions")"
  touch "$exclusions"

  if ! grep -qxF -- "$REGION_START" "$exclusions"; then
    if [[ -s $exclusions && -n $(tail -c1 "$exclusions") ]]; then
      echo >>"$exclusions"
    fi
    printf '%s\n%s\n' "$REGION_START" "$REGION_END" >>"$exclusions"
  fi

  P=/$1 awk -v e="$REGION_END" '$0 == e { print ENVIRON["P"] } { print }' "$exclusions" >"$exclusions.tmp"
  mv "$exclusions.tmp" "$exclusions"
}

# Removes a path from git-hide's region of the exclude file
remove_exclude() {
  [[ -f $exclusions ]] || return 0

  P=/$1 awk -v s="$REGION_START" -v e="$REGION_END" '
    $0 == s { f = 1 }
    $0 == e { f = 0 }
    !(f && $0 == ENVIRON["P"])
  ' "$exclusions" >"$exclusions.tmp"

  mv "$exclusions.tmp" "$exclusions"
}

# Removes git-hide's full region from the exclude file
clear_excludes() {
  [[ -f $exclusions ]] || return 0

  awk -v s="$REGION_START" -v e="$REGION_END" '
    $0 == s { f = 1; next }
    $0 == e { f = 0; next }
    !f
  ' "$exclusions" >"$exclusions.tmp"

  mv "$exclusions.tmp" "$exclusions"
}

# Whether a path is tracked
is_tracked() {
  git --literal-pathspecs ls-files --error-unmatch -- "$1" >/dev/null 2>&1
}

# set_skip_worktree <--skip-worktree|--no-skip-worktree> <path>...
# One path at a time
set_skip_worktree() {
  local flag=$1 p
  shift
  for p in "$@"; do
    git update-index "$flag" -- "$p" || warn "could not update $p"
  done
}

# Lists all hidden paths, with a prefix indicating whether they are skip-worktree or excluded
cmd_list() {
  skip_worktree_paths | tr '\0' '\n' | awk '{ print "S " $0 }'
  excluded_paths | awk '{ print "X " $0 }'
}

# Hide provided paths.
#
# If a file is tracked, it is marked skip-worktree.
# If it is untracked, it is added to the exclude file.
# If it is staged but not committed, it is unstaged and excluded.
cmd_hide() {
  [[ $# -gt 0 ]] || die 'usage: git hide <path>...'
  local f p

  for f in "$@"; do
    p=$(rel "$f")

    if is_tracked "$p"; then
      if git cat-file -e "HEAD:$p" 2>/dev/null; then
        git update-index --skip-worktree -- "$p"
        continue
      fi

      warn "$p is staged but not committed, unstaging it"
      git rm --cached -q -- "$p"
    fi

    if ! is_excluded "$p"; then
      add_exclude "$p"
    fi
  done
}

# Unhides paths.
#
# If a file is tracked, it is marked no-skip-worktree.
# If it is untracked, it is removed from the exclude file.
cmd_unhide() {
  [[ $# -gt 0 ]] || die 'usage: git unhide <path>...'
  local f p

  for f in "$@"; do
    p=$(rel "$f")

    if is_tracked "$p"; then
      git update-index --no-skip-worktree -- "$p"
    fi

    remove_exclude "$p"
  done
}

# Unhides all hidden files, both skip-worktree and excluded
cmd_unhide_all() {
  local -a paths=()
  mapfile -d '' -t paths < <(skip_worktree_paths)
  set_skip_worktree --no-skip-worktree "${paths[@]}"
  clear_excludes
}

# Records that were saved for stashes which no longer exist are dropped.
prune_records() {
  [[ -d $records ]] || return 0
  local live f
  live=$(git stash list --format=%H)
  for f in "$records"/*; do
    [[ -e $f ]] || continue
    if ! grep -qxF -- "${f##*/}" <<<"$live"; then
      rm -f -- "$f"
    fi
  done
}

# Stash all hidden paths.
#
# Only skip-worktree files have to be unhidden for `git stash` to see them.
# Excluded files are untracked, so stash ignores them either way and the exclusion region is left alone.
#
# The hidden files that ended up in the stash are saved under the stash's commit id, so `unstash` can hide them again.
cmd_stash() {
  local -a hidden=() kept=()
  local -A in_stash=()
  local before after p rc=0

  mapfile -d '' -t hidden < <(skip_worktree_paths)
  set_skip_worktree --no-skip-worktree "${hidden[@]}"

  before=$(git rev-parse -q --verify refs/stash || true)
  git stash "$@" || rc=$?
  after=$(git rev-parse -q --verify refs/stash || true)

  set_skip_worktree --skip-worktree "${hidden[@]}"

  if [[ -n $after && $after != "$before" && ${#hidden[@]} -gt 0 ]]; then
    while IFS= read -r -d '' p; do
      in_stash[$p]=1
    done < <(git diff --name-only --no-renames -z "$after^1" "$after")

    for p in "${hidden[@]}"; do
      if [[ -n ${in_stash[$p]-} ]]; then
        kept+=("$p")
      fi
    done

    if [[ ${#kept[@]} -gt 0 ]]; then
      mkdir -p "$records"
      printf '%s\0' "${kept[@]}" >"$records/$after"
    fi
  fi

  prune_records
  return "$rc"
}

# Unstash all previously hidden paths.
#
# Pop the stash from `stash`, and then hide whatever the stash touched among previously hidden paths.
cmd_unstash() {
  local -a paths=() unmerged=() rehide=()
  local -A conflicted=()
  local ref='stash@{0}' a sha record p rc=0

  for a in "$@"; do
    if [[ $a != -* ]]; then
      ref=$a
    fi
  done

  if [[ $ref =~ ^[0-9]+$ ]]; then
    ref="stash@{$ref}"
  fi

  sha=$(git rev-parse -q --verify "$ref") || die "no such stash: $ref"

  record=$records/$sha
  if [[ -f $record ]]; then
    mapfile -d '' -t paths <"$record"
  else
    warn "no hidden files recorded for $ref, popping it as is"
  fi

  set_skip_worktree --no-skip-worktree "${paths[@]}"
  git stash pop "$@" || rc=$?

  # Files with conflicts have to stay visible
  mapfile -d '' -t unmerged < <(git ls-files -u -z | awk -v RS='\0' -v ORS='\0' '{ sub(/^[^\t]*\t/, ""); print }')
  for p in "${unmerged[@]}"; do
    conflicted[$p]=1
  done

  for p in "${paths[@]}"; do
    if [[ -z ${conflicted[$p]-} ]]; then
      rehide+=("$p")
    fi
  done

  set_skip_worktree --skip-worktree "${rehide[@]}"

  if [[ $rc -eq 0 ]]; then
    rm -f -- "$record"
  elif [[ ${#conflicted[@]} -gt 0 ]]; then
    warn "left visible because of conflicts: ${!conflicted[*]}"
  fi

  return "$rc"
}

# Begin main program

[[ $# -gt 0 ]] || usage
command=$1
shift

case $command in
  list) cmd_list ;;
  hide) cmd_hide "$@" ;;
  unhide) cmd_unhide "$@" ;;
  unhide-all) cmd_unhide_all ;;
  stash) cmd_stash "$@" ;;
  unstash) cmd_unstash "$@" ;;
  *) usage ;;
esac
