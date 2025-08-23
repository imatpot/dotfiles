{...}: {
  disko.devices.disk = {
    nvme0n1 = {
      type = "disk";
      device = "/dev/nvme0n1";

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            label = "boot";
            size = "512M";
            type = "EF00";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "umask=0077"
              ];
            };
          };

          root = {
            # configured via nvme1.content.partitions.root.content.extraArgs
            label = "root0";
            size = "100%";
          };
        };
      };
    };

    nvme1n1 = {
      type = "disk";
      device = "/dev/nvme1n1";

      content = {
        type = "gpt";

        partitions = {
          root = {
            label = "root1";
            size = "100%";

            content = {
              type = "btrfs";

              extraArgs = builtins.concatLists [
                ["--force"]
                ["--label" "nixos"]
                ["--data" "single"]
                ["--metadata" "raid1"]
                ["/dev/disk/by-partlabel/root0" "/dev/disk/by-partlabel/root1"]
              ];

              subvolumes = {
                "/root" = {};

                "/root/active" = {
                  mountpoint = "/";
                  mountOptions = ["compress=zstd" "noatime"];
                };

                "/root/snapshots" = {
                  mountpoint = "/snapshots";
                  mountOptions = ["compress=zstd" "noatime"];
                };

                "/home" = {};

                "/home/active" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd" "noatime"];
                };

                "/home/snaphosts" = {
                  mountpoint = "/snapshots/home";
                  mountOptions = ["compress=zstd" "noatime"];
                };

                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd" "noatime"];
                };
              };
            };
          };
        };
      };
    };
  };
}
