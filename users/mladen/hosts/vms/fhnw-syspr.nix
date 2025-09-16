{
  outputs,
  system,
  hostname,
  ...
}:
outputs.lib.mkFor system hostname {
  hosts.atlas = {
    modules = {
      stylix.system-wide = true;

      backblaze.enable = false;
      bitwarden.enable = false;
      video.enable = false;

      development.adb.enable = false;
    };
  };
}
