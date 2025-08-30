{
  outputs,
  system,
  hostname,
  ...
}:
outputs.lib.mkFor system hostname {
  hosts.atlas = {
    modules = {
      samba.enable = true;
      stylix.system-wide = true;
    };
  };
}
