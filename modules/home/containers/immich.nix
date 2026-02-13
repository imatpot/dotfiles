{
  outputs,
  config,
  osConfig,
  ...
}:
outputs.lib.mkModule config false "containers.immich"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.immich.dirs.root is not set";
    };

    media = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.jellyfin.dirs.media is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.immich;
    baseDir = "${cfg.dirs.root}/data/immich-server/data";
    dbDir = "${cfg.dirs.root}/data/immich-postgres/data";
    modelDir = "${cfg.dirs.root}/data/immich-machine-learning/model-cache";
  in {
    sops.templates.immich-env.content = ''
      IMMICH_VERSION=release

      # Please use only the characters `A-Za-z0-9`, without special characters or spaces
      DB_PASSWORD=${config.sops.placeholder."containers/immich/db_password"}
      DB_USERNAME=postgres
      DB_DATABASE_NAME=immich
      DB_HOSTNAME=${osConfig.virtualisation.oci-containers.containers.immich-postgres.hostname}

      # Please use only the characters `A-Za-z0-9`, without special characters or spaces
      POSTGRES_PASSWORD=${config.sops.placeholder."containers/immich/db_password"}
      POSTGRES_USER=postgres
      POSTGRES_DB=immich
      POSTGRES_INITDB_ARGS="--data-checksums"

      REDIS_HOSTNAME=${osConfig.virtualisation.oci-containers.containers.immich-redis.hostname}
    '';

    nixos = {
      system.ensureDirectories = [
        baseDir
        dbDir
        modelDir
      ];

      virtualisation.oci-containers = {
        containers = {
          immich-server = {
            image = "ghcr.io/immich-app/immich-server:release";
            pull = "newer";

            hostname = "immich_server";
            autoStart = true;
            autoRemoveOnStop = false;

            environmentFiles = [
              config.sops.templates.immich-env.path
            ];

            ports = [
              "2283:2283"
            ];

            volumes = [
              "${baseDir}:/data"
              "${cfg.dirs.media}:/mnt"
              "/etc/localtime:/etc/localtime:ro"
            ];

            devices = [
              "nvidia.com/gpu=all"
            ];

            dependsOn = [
              "immich-redis"
              "immich-postgres"
            ];
          };

          immich-postgres = {
            image = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0@sha256:bcf63357191b76a916ae5eb93464d65c07511da41e3bf7a8416db519b40b1c23";
            hostname = "immich_postgres";

            volumes = [
              "${dbDir}:/var/lib/postgresql/data"
            ];

            environmentFiles = [
              config.sops.templates.immich-env.path
            ];
          };

          immich-machine-learning = {
            image = "ghcr.io/immich-app/immich-machine-learning:release";
            pull = "newer";

            hostname = "immich_machine_learning";

            volumes = [
              "${modelDir}:/cache"
            ];

            devices = [
              "nvidia.com/gpu=all"
            ];

            environmentFiles = [
              config.sops.templates.immich-env.path
            ];
          };

          immich-redis = {
            image = "docker.io/valkey/valkey:9@sha256:546304417feac0874c3dd576e0952c6bb8f06bb4093ea0c9ca303c73cf458f63";
            hostname = "immich_redis";
          };
        };
      };
    };
  }
)
