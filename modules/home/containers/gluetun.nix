{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.gluetun"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.gluetun.dirs.root is not set";
    };
  };

  vpn = {
    type = outputs.lib.mkOption {
      type = outputs.lib.types.str;
      default = throw "dotfiles: containers.gluetun.vpn.type is not set";
    };

    provider = outputs.lib.mkOption {
      type = outputs.lib.types.str;
      default = throw "dotfiles: containers.gluetun.vpn.proivder is not set";
    };

    portForwarding = {
      enable = outputs.lib.mkDefaultEnableOption false;
    };
  };
}
(
  let
    cfg = config.modules.containers.gluetun;
    configDir = "${cfg.dirs.root}/data/gluetun/config";
  in {
    nixos = {
      system.ensureDirectories = [
        configDir
      ];

      virtualisation.oci-containers = {
        containers = {
          gluetun = {
            image = "ghcr.io/qdm12/gluetun";
            pull = "newer";

            autoStart = true;
            autoRemoveOnStop = false;

            environment = {
              VPN_SERVICE_PROVIDER = cfg.vpn.provider;
              VPN_TYPE = cfg.vpn.type;

              VPN_PORT_FORWARDING = outputs.lib.mkIf cfg.vpn.portForwarding.enable "on";
              PORT_FORWARD_ONLY = outputs.lib.mkIf cfg.vpn.portForwarding.enable "on";

              UPDATE_PERIOD = "24h";
            };

            environmentFiles = [
              (cfg.dirs.root + "/.env")
            ];

            capabilities = {
              NET_ADMIN = true;
            };

            devices = [
              "/dev/net/tun:/dev/net/tun"
            ];

            ports = [
              "8888:8888"
              "8388:8388"
              "8388:8388/udp"
            ];

            volumes = [
              "${configDir}:/gluetun"
            ];
          };
        };
      };
    };
  }
)
