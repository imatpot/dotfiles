{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.comfyui"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.comfyui.dirs.root is not set";
    };

    models = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.comfyui.dirs.models is not set";
    };

    nodes = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.comfyui.dirs.nodes is not set";
    };

    workflows = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.comfyui.dirs.workflows is not set";
    };

    outputs = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.comfyui.dirs.outputs is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.comfyui;
    userDir = "${cfg.dirs.root}/data/comfyui/user";
  in {
    nixos = {
      system.ensureDirectories = [
        cfg.dirs.root
        cfg.dirs.models
        cfg.dirs.nodes
        cfg.dirs.workflows
        cfg.dirs.outputs
        userDir
      ];

      virtualisation.oci-containers = {
        containers = {
          comfyui = {
            image = "ghcr.io/imatpot/comfyui";
            pull = "newer";

            cmd = [
              "python"
              "main.py"
              "--listen=0.0.0.0"
            ];

            autoStart = true;
            autoRemoveOnStop = false;

            ports = [
              "8188:8188"
            ];

            devices = [
              "nvidia.com/gpu=all"
            ];

            volumes = [
              "${userDir}:/comfyui/user"
              "${cfg.dirs.workflows}:/comfyui/user/default/workflows"
              "${cfg.dirs.nodes}:/comfyui/custom_nodes"
              "${cfg.dirs.models}:/comfyui/models"
              "${cfg.dirs.outputs}:/comfyui/output"
            ];
          };
        };
      };
    };
  }
)
