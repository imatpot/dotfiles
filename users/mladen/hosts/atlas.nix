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

        jellyfin = {
          enable = true;

          dirs = {
            root = containers + "/jellyfin";
            media = data;
          };
        };

        lidarr = {
          enable = true;

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
      };
    };
  };
}
