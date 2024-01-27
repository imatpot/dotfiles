#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash git jq nix-output-monitor

#-----------------------------------------------------------------------------------#
# Largely plagiarized from https://github.com/runarsf/dotfiles/blob/main/rebuild.sh #
#-----------------------------------------------------------------------------------#

set -o errexit  # Exit on error
set -o nounset  # Error on undefined variables
set -o pipefail # Error when piping fails
set -o posix    # Enforce POSIX compliance

shopt -s extglob  # Enable extended globbing
shopt -s extdebug # Enable extended debugging

OS="$(uname)"
HOSTNAME="$(hostname)"
USER="$(whoami)"

# Make sure the script works on systems without Flakes enabled
NIX="nix --experimental-features 'nix-command flakes'"

# The script will live in the Nix store, so we sadly need to hardcode this to use as default flake location
DOTS_PATH="${HOME}/.config/dotfiles"

BUILDER= # Builder to be used
FLAKE=   # Full Flake, e.g. "github:imatpot/dotfiles#shinobi"
URL=     # Flake URL, e.g. "github:imatpot/dotfiles" (without #-suffix)
NAME=    # Flake output name, e.g. "shinobi" (without #-prefix)
ARGS=()  # Additional arguments to be passed to the builder

DEBUG=false # Show debug information
RAW=false   # Use raw nix build instead of builders

debug() {
    printf "%s" "${BASH_LINENO}" >&2                # Line number
    printf " \e[33m%s\e[0m\n" "${BASH_COMMAND}" >&2 # Command in yellow
}

build_nixos() {
    if [ "${1}" = "build" ] && [ "${RAW}" = true ]; then
        # Allow triggering raw build on systems without nixos-rebuild
        eval $NIX build "${URL}#nixosConfigurations.${NAME}.config.system.build.toplevel" ${ARGS[@]:1} |& nom
        exit 0
    fi

    if [ "${OS}" != "Linux" ]; then
        printf "Cannot run nixos-rebuild on ${OS}\n" >&2
        exit 1
    elif ! command -v nixos-rebuild &>/dev/null; then
        printf "Command nixos-rebuild not found. Are you on NixOS?\n" >&2
        exit 1
    fi

    local subcommand="${1}"

    if [ "${1}" = "activate" ]; then
        # Interopability with nix-darwin
        subcommand="test"
    fi

    sudo true
    sudo nixos-rebuild --flake "${FLAKE}" "${subcommand}" ${@:2} |& nom
}

build_darwin() {
    if [ "${1}" = "build" ] && [ "${RAW}" = true ]; then
        # Allow triggering raw build on systems without nix-darwin
        eval $NIX build "${URL}#darwinConfigurations.${NAME}.config.system.build.toplevel" ${ARGS[@]:1} |& nom
        exit 0
    fi

    if [ "${OS}" != "Darwin" ]; then
        printf "Cannot run darwin-rebuild on ${OS}\n" >&2
        exit 1
    fi

    local subcommand="${1}"

    if [ "${subcommand}" = "test" ]; then
        # Interopability with nixos-rebuild
        subcommand="activate"
    fi

    local darwin_rebuild="$(command -v darwin-rebuild || printf 'nix run github:lnl7/nix-darwin --')"

    sudo true
    eval $darwin_rebuild --flake "${FLAKE}" "${subcommand}" ${@:2} |& nom
}

build_home() {
    local home_manager="$(command -v home-manager || printf 'nix run github:nix-community/home-manager --')"
    eval $home_manager --flake "${FLAKE}" ${@}
}

find_os_builder() {
    if [ "${OS}" = "Linux" ]; then
        BUILDER="nixos"
    elif [ "${OS}" = "Darwin" ]; then
        BUILDER="darwin"
    else
        printf "Unsupported OS: ${OS}\n" >&2
        exit 1
    fi
}

find_config() {
    local configs="$(eval $NIX eval "${URL}#${1}Configurations" --apply builtins.attrNames --json 2>/dev/null || printf '[]\n')"
    printf "${configs}" | jq -e "index(\"${2}\")" &>/dev/null
}

apply_default_args() {
    if [ ! -d "${DOTS_PATH}" ]; then
        printf "\e[33m%s\e[0m " "${DOTS_PATH} doesn't exist yet."
        read -p "Clone now? [y/N] " -n 1 -r
        printf "\n"
        if [ "${REPLY}" = "Y" ] || [ "${REPLY}" = "y" ]; then
            git clone git@github.com:imatpot/dotfiles.git "${DOTS_PATH}" 2>/dev/null || git clone https://github.com/imatpot/dotfiles.git "${DOTS_PATH}3"
        fi
    fi

    URL="path:${DOTS_PATH}"
    NAME="" # Let Nix figure out the output name
    FLAKE="${URL}"
    ARGS=("build")

    if find_config nixos "${HOSTNAME}"; then
        BUILDER="nixos"
    elif find_config darwin "${HOSTNAME}"; then
        BUILDER="darwin"
    elif find_config home "${USER}@${HOSTNAME}" || find_config home "${USER}"; then
        BUILDER="home"
    else
        BUILDER="nixos"
    fi
}

parse_args() {
    USE_FLAKE=false
    USE_URL=false
    USE_NAME=false

    while [ "${#}" -gt "0" ]; do
        case "${1}" in
        os | system)
            find_os_builder
            shift
            ;;
        nixos)
            BUILDER="nixos"
            shift
            ;;
        darwin)
            BUILDER="darwin"
            shift
            ;;
        home | home-manager)
            BUILDER="home"
            shift
            ;;
        -f | --flake)
            USE_FLAKE=true
            FLAKE="${2}"
            shift 2
            ;;
        -u | --url)
            USE_URL=true
            URL="${2}"
            shift 2
            ;;
        -n | --name)
            USE_NAME=true
            NAME="${2}"
            shift 2
            ;;
        -r | --raw)
            RAW=true
            shift
            ;;
        -d | --debug)
            DEBUG=true
            shift
            ;;
        -??*)
            # Nix doesn't handle chained short options, so we split them, e.g. "-xyz" -> "-x -yz" -> "-x -y -z"
            local opt="${1}"
            shift
            set -- "${opt:0:2}" "-${opt:2}" "${@}"
            ;;
        !(*-*))
            # If the argument doesn't contain a dash, first check if it's a configuration name
            if find_config nixos "${1}"; then
                BUILDER="nixos"
                NAME="${1}"
            elif find_config darwin "${1}"; then
                BUILDER="darwin"
                NAME="${1}"
            elif find_config home "${1}"; then
                BUILDER="home"
                NAME="${1}"
            else
                # If it's not a configuration name, it's a subcommand
                ARGS[0]="${1}"
            fi
            shift
            ;;
        *)
            ARGS+=("${1}")
            shift
            ;;
        esac
    done

    if [ "${USE_FLAKE}" = true ] && [ "${USE_URL}" = true ]; then
        printf "Conflicting arguments --flake and --url\n" >&2
        exit 1
    elif [ "${USE_FLAKE}" = true ] && [ "${USE_NAME}" = true ]; then
        printf "Conflicting arguments --flake and --name\n" >&2
        exit 1
    elif [ "${USE_URL}" = true ] && [ "${USE_NAME}" = false ]; then
        FLAKE="${URL}" # Omit "#" so Nix doesn't check for an empty name
    elif [ "${USE_NAME}" = true ]; then
        FLAKE="${URL}#${NAME}"
    fi

    if [ "${RAW}" = true ] && [ -z "${NAME}" ]; then
        printf "Cannot use --raw without --name\n" >&2
        exit 1
    fi
}

main() {
    parse_args "${@}"

    if [ "${DEBUG}" = true ]; then
        trap debug DEBUG
    fi

    case "${BUILDER}" in
    nixos)
        build_nixos "${ARGS[@]}"
        ;;
    darwin)
        build_darwin "${ARGS[@]}"
        ;;
    home)
        build_home "${ARGS[@]}"
        ;;
    *)
        printf "Unknown builder: ${BUILDER}\n" >&2
        exit 1
        ;;
    esac

    if [ "${DEBUG}" = true ]; then
        trap - DEBUG
    fi

    # Show post-run messages

    printf "\n"

    case "${ARGS[0]}" in
    build)
        printf "\e[32m%s\e[0m " "Build success!"
        read -p "Switch now? [y/N] " -n 1 -r
        printf "\n\n"
        if [ "${REPLY}" = "Y" ] || [ "${REPLY}" = "y" ]; then
            ARGS[0]="switch"
            main "${ARGS[@]}"
        fi
        ;;
    test | activate)
        printf "\e[32m%s\e[0m " "Build success!"
        printf "Remember to switch if everything looks good:\n\n"
        printf "$ %s switch %s\n" "$(basename "${0}")" "${BUILDER} ${ARGS[@]:1}"
        ;;
    switch)
        printf "\e[32m%s\e[0m " "Switch success!"
        printf "Have fun with the new config :)\n"
        ;;
    esac
}

apply_default_args

main "${@}"
exit "${?}"
