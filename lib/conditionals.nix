{outputs, ...}:
with outputs.lib; {
  isLinux = hasSuffix "linux";
  isDarwin = hasSuffix "darwin";

  isWayland = config: config.home.sessionVariables ? NIXOS_OZONE_WL;

  mkFor = system: hostname: {
    common ? {},
    systems ? {},
    hosts ? {},
  }: let
    systemConfig =
      if isLinux system
      then systems.linux or {}
      else if isDarwin system
      then systems.darwin or {}
      else {};
    hostConfig =
      if hostname != null
      then hosts.${hostname} or {}
      else {};
  in
    deepMerge [
      common
      systemConfig
      hostConfig
    ];
}
