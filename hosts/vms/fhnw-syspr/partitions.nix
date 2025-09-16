{...}: {
  disko.devices.disk = {
    vda1 = {
      type = "disk";
      device = "/dev/vda1";

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
              mountOptions = ["umask=0077"];
            };
          };

          root = {
            label = "root";
            size = "100%";

            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
