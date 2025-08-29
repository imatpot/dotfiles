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

  mkModule' = config: default: name: moduleConfig:
    mkModule config default name {} moduleConfig;

  mkModule'' = config: name: moduleOptions:
    mkModule config true name moduleOptions {};

  mkDefaultEnableOption = default:
    mkOption {
      inherit default;
      type = types.bool;
    };
}
