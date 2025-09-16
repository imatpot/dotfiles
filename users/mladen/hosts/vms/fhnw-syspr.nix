{
  outputs,
  system,
  hostname,
  ...
}:
outputs.lib.mkFor system hostname {
  hosts.fhnw-syspr = {
    modules = {
      stylix.system-wide = true;

      backblaze.enable = false;
      bitwarden.enable = false;
      video.enable = false;

      dev.adb.enable = false;
    };
  };
}
