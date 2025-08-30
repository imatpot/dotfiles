{outputs, ...}:
with outputs.lib; {
  mkModule = config: default: name: moduleOptions: moduleConfig: let
    path = splitString "." name;
  in {
    options.modules = setAttrByPath path (
      moduleOptions
      // {
        enable = mkDefaultEnableOption default;
      }
    );

    config = mkIf (getAttrFromPath path config.modules).enable moduleConfig;
  };

  mkConfigModule = config: default: name: moduleConfig:
    mkModule config default name {} moduleConfig;

  mkOptionsModule = config: default: name: moduleOptions:
    mkModule config default name moduleOptions {};

  mkDefaultEnableOption = default:
    mkOption {
      inherit default;
      type = types.bool;
    };
}
