{
  outputs,
  system,
  hostname,
  config,
  ...
}:
outputs.lib.mkFor system hostname {
  hosts.atlas = {
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
      };
    };
  };
}
