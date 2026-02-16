{
  outputs,
  system,
  hostname,
  config,
  pkgs,
  ...
}:
outputs.lib.mkFor system hostname {
  hosts.atlas = {
    home.packages = with pkgs; [
      zellij
      pv
      pigz
      yazi
    ];

    modules = {
      samba.enable = true;
      stylix.system-wide = true;

      containers = let
        data = config.home.homeDirectory + "/data";
        containers = data + "/software/containers";
      in {
        lunaro-manager = {
          enable = true;

          dirs = {
            root = containers + "/lunaro-manager";
          };
        };

        immich = {
          enable = true;

          dirs = {
            root = containers + "/immich";
            media = data;
          };
        };

        jellyfin = {
          enable = true;

          dirs = {
            root = containers + "/jellyfin";
            media = data;
          };
        };

        stremio = {
          enable = true;

          dirs = {
            root = containers + "/stremio";
          };
        };

        lidarr = {
          enable = false;

          dirs = {
            root = containers + "/lidarr";
            media = data + "/audio/music";
          };
        };

        jackett = {
          enable = false;

          dirs = {
            root = containers + "/jackett";
          };
        };

        prowlarr = {
          enable = false;

          dirs = {
            root = containers + "/prowlarr";
          };
        };

        qbittorrent = {
          enable = true;

          dirs = {
            root = containers + "/qbittorrent";
          };
        };

        slskd = {
          enable = true;

          dirs = {
            root = containers + "/slskd";
            downloads = data + "/audio/slskd";
          };
        };

        gluetun = {
          enable = true;

          dirs = {
            root = containers + "/gluetun";
          };

          vpn = {
            provider = "protonvpn";
            type = "wireguard";
          };
        };

        comfyui = {
          enable = true;

          dirs = {
            root = "${containers}/comfyui";
            models = "${data}/software/ai/stable-diffusion/models";
            nodes = "${data}/software/ai/stable-diffusion/nodes";
            workflows = "${data}/software/ai/stable-diffusion/workflows";
            outputs = data;
          };
        };
      };
    };
  };
}
