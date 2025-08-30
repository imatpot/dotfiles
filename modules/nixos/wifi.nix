{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "wifi" {
  sops.templates.networkmanager-env.content = ''
    TRONDHEIM_PSK=${config.sops.placeholder."wifi/trondheim"}
  '';

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      config.sops.templates.networkmanager-env.path
    ];

    profiles = {
      trondheim = {
        connection = {
          id = "Trondheim";
          type = "wifi";
        };

        wifi = {
          ssid = "Trondheim";
          mode = "infrastructure";
        };

        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
          psk = "$TRONDHEIM_PSK";
        };

        ipv4.mode = "auto";
        ipv6.mode = "auto";
      };
    };
  };
}
