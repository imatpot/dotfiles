{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config true "helix" {
  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;

    languages.language = [
      {
        name = "nix";
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        language-servers = ["nil"];
        formatter = {
          command = "alejandra";
        };
      }
      {
        name = "rust";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
        language-servers = ["rust-analyzer"];
        formatter = {
          command = "rustfmt";
        };
      }
    ];

    themes = {
      code = {
        inherits = "dark_plus";
        "ui.background" = "none";
      };
    };

    settings = {
      theme = outputs.lib.mkForce "code";

      editor = {
        mouse = false;
        scroll-lines = 0;
        line-number = "relative";
        default-yank-register = "+";
        auto-format = false;
        bufferline = "always";

        statusline = {
          mode = {
            normal = "N";
            insert = "I";
            select = "S";
          };

          left = [
            "mode"
            "spinner"
            "read-only-indicator"
            "version-control"
            "workspace-diagnostics"
          ];
          center = [];
          right = [
            "file-encoding"
            "selections"
            "position"
            "register"
          ];
        };

        lsp = {
          display-inlay-hints = true;
          display-progress-messages = true;
        };

        file-picker = {
          hidden = false;
          git-ignore = false;
          git-global = false;
        };

        indent-guides = {
          render = true;
          character = "▏";
        };

        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "warning";
        };
      };

      keys = {
        normal = {
          "-" = {
            f = ":format";
            s = ":w";
            q = ":q";
            z = ":wq";
          };
        };
      };
    };
  };
}
