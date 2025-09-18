{
  config,
  outputs,
  system,
  hostname,
  ...
}: let
  extra = ''
    ssh-add ~/.ssh/aegis &> /dev/null
    ssh-add ~/.ssh/mladen.brankovic.at.golog.ch &> /dev/null
    ssh-add ~/.ssh/mladen.brankovic.at.students.fhnw.ch &> /dev/null

    alias nixvim="nix run path:/Users/mladen/Developer/life/nixvim --"
    alias nv="nixvim"

    export PATH="$PATH:${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/share/npm/bin:/opt/homebrew/bin"
  '';
in
  outputs.lib.mkFor system hostname {
    hosts.mcdonalds = {
      modules = {
        fonts.enable = true;
        dev = {
          adb.enable = true;
          csharp.enable = true;
          databases.enable = true;
          flutter.enable = true;
          haskell.enable = true;
          javascript.enable = true;
          kubernetes.enable = true;
          azure.enable = true;
          plantuml.enable = true;
          python.enable = true;
          rust.enable = true;
          typst.enable = true;
        };
      };

      home.file.backblaze-id.source =
        config.lib.file.mkOutOfStoreSymlink
        config.sops.secrets."backblaze/id".path;

      sops.templates.git.content =
        # toml
        ''
          # interpolated comment for testing
          # backblaze.id = ${config.sops.placeholder."backblaze/id"}
        '';

      programs = {
        bash.initExtra = extra;
        zsh.initContent = extra;

        git = {
          userName = outputs.lib.mkForce "Mladen Branković";
          userEmail = outputs.lib.mkForce "mladen.brankovic@golog.ch";
          signing = outputs.lib.mkForce {
            key = "588B95BE8E35DD34";
            signByDefault = true;
          };

          includes = [
            {
              path = config.sops.templates.git.path;
            }
          ];
        };

        ssh.extraConfig = ''
          Host gitlab.com
            Hostname altssh.gitlab.com
            Port 443
        '';
      };
    };
  }
