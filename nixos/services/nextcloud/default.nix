{ pkgs, lib, config, ... }:

with lib;

let
  nextcloudDomain = "nextcloud.routing.rocks";
  timezone = "Europe/Berlin";
  cfg = config.my.services.nextcloud;

in {
  options = {
    my.services.nextcloud = {
      enable = mkEnableOption "Nextcloud (All In One)";

      databasePassword = mkOption {
        type = types.str;
        description = "Password for the PostgreSQL database";
      };

      redisPassword = mkOption {
        type = types.str;
        description = "Password for Redis";
      };

      nextcloudPassword = mkOption {
        type = types.str;
        description = "Password for the admin account";
      };

      fulltextsearchPassword = mkOption {
        type = types.str;
        description = "Password for the full text search";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.podman-create-nextcloud-net = {
      serviceConfig.Type = "oneshot";
      wantedBy = [
        "podman-nextcloud-aio-apache.service"
        "podman-nextcloud-aio-database.service"
        "podman-nextcloud-aio-nextcloud.service"
        "podman-nextcloud-aio-notify-push.service"
        "podman-nextcloud-aio-redis.service"
        "podman-nextcloud-aio-clamav.service"
        "podman-nextcloud-aio-imaginary.service"
        "podman-nextcloud-aio-fulltextsearch.service"
      ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists nextcloud || podman network create nextcloud
      '';
    };

    virtualisation.oci-containers.containers = {
      nextcloud-aio-apache = {
        image = "nextcloud/aio-apache";

        autoStart = true;
        extraOptions = [
          "--network=nextcloud"
          "--read-only"
          "--read-only-tmpfs"
          "--mount=type=tmpfs,destination=/var/log/supervisord,rw=true"
          "--mount=type=tmpfs,destination=/var/run/supervisord,rw=true"
          "--mount=type=tmpfs,destination=/usr/local/apache2/logs,rw=true"
          "--mount=type=tmpfs,destination=/home/www-data,rw=true"
        ];

        environment = {
          NC_DOMAIN = "${nextcloudDomain}";
          NEXTCLOUD_HOST = "nextcloud-aio-nextcloud";
          NOTIFY_PUSH_HOST = "nextcloud-aio-notify-push";
          TZ = "${timezone}";
          APACHE_PORT = "11000";
          APACHE_MAX_SIZE = "10737418240";
          APACHE_MAX_TIME = "3600";
        };

        volumes = [
          "nextcloud_aio_nextcloud:/var/www/html:ro"
          "nextcloud_aio_apache:/mnt/data:rw"
        ];

        ports = [
          "127.0.0.1:11000:11000"
        ];
      };

      nextcloud-aio-database = {
        image = "nextcloud/aio-postgresql";

        autoStart = true;
        extraOptions = [
          "--network=nextcloud"
          "--read-only"
          "--shm-size=268435456"
          "--mount=type=tmpfs,destination=/var/run/postgresql,rw=true"
        ];

        environment = {
          POSTGRES_USER = "nextcloud";
          POSTGRES_DB = "nextcloud_database";
          POSTGRES_PASSWORD = "${cfg.databasePassword}";
          TZ = "${timezone}";
          PGTZ = "${timezone}";
        };

        volumes = [
          "nextcloud_aio_database:/var/lib/postgresql/data:rw"
          "nextcloud_aio_database_dump:/mnt/data:rw"
        ];
      };

      nextcloud-aio-nextcloud = {
        image = "nextcloud/aio-nextcloud";

        autoStart = true;
        extraOptions = [
          "--network=nextcloud"
        ];

        environment = {
          TZ = "${timezone}";
          NEXTCLOUD_DATA_DIR = "/mnt/ncdata";
          POSTGRES_HOST = "nextcloud-aio-database";
          POSTGRES_PASSWORD = "${cfg.databasePassword}";
          POSTGRES_DB = "nextcloud_database";
          POSTGRES_USER = "nextcloud";
          REDIS_HOST = "nextcloud-aio-redis";
          REDIS_HOST_PASSWORD = "${cfg.redisPassword}";
          NC_DOMAIN = "${nextcloudDomain}";
          ADMIN_USER = "admin";
          ADMIN_PASSWORD = "${cfg.nextcloudPassword}";
          OVERWRITEHOST = "${nextcloudDomain}";
          OVERWRITEPROTOCOL = "https";
          CLAMAV_ENABLED = "yes";
          CLAMAV_HOST = "nextcloud-aio-clamav";
          ONLYOFFICE_ENABLED = "no";
          COLLABORA_ENABLED = "no";
          TALK_ENABLED = "no";
          UPDATE_NEXTCLOUD_APPS = "no";
          IMAGINARY_ENABLED = "yes";
          IMAGINARY_HOST = "nextcloud-aio-imaginary";
          PHP_UPLOAD_LIMIT = "10G";
          PHP_MEMORY_LIMIT = "512M";
          FULLTEXTSEARCH_ENABLED = "yes";
          FULLTEXTSEARCH_HOST = "nextcloud-aio-fulltextsearch";
          PHP_MAX_TIME = "3600";
          ADDITIONAL_APKS = "imagemagick";
          ADDITIONAL_PHP_EXTENSIONS = "imagick";
          FULLTEXTSEARCH_PASSWORD = "${cfg.fulltextsearchPassword}";
          REMOVE_DISABLED_APPS = "yes";
          APACHE_PORT = "11000";
          APACHE_IP_BINDING = "127.0.0.1";
        };

        volumes = [
          "nextcloud_aio_nextcloud:/var/www/html:rw"
          "nextcloud_aio_nextcloud_data:/mnt/ncdata:rw"
        ];

        dependsOn = [
          "nextcloud-aio-database"
          "nextcloud-aio-redis"
        ];
      };

      nextcloud-aio-redis = {
        image = "nextcloud/aio-redis";

        autoStart = true;
        extraOptions = [
          "--network=nextcloud"
          "--read-only"
        ];

        environment = {
          TZ = "${timezone}";
          REDIS_HOST_PASSWORD = "${cfg.redisPassword}";
        };

        volumes = [
          "nextcloud_aio_redis:/data:rw"
        ];
      };

      nextcloud-aio-clamav = {
        image = "nextcloud/aio-clamav";

        autoStart = true;
        extraOptions = [
          "--network=nextcloud"
          "--read-only"
          "--read-only-tmpfs"
          "--mount=type=tmpfs,destination=/var/lock,rw=true"
          "--mount=type=tmpfs,destination=/var/log/clamav,rw=true"
        ];

        environment = {
          TZ = "${timezone}";
          CLAMD_STARTUP_TIMEOUT = "90";
        };

        volumes = [
          "nextcloud_aio_clamav:/var/lib/clamav:rw"
        ];
      };

      nextcloud-aio-notify-push = {
        image = "nextcloud/aio-notify-push";

        autoStart = true;
        extraOptions = [
          "--network=nextcloud"
          "--read-only"
        ];

        environment = {
          NC_DOMAIN = "${nextcloudDomain}";
          NEXTCLOUD_HOST = "nextcloud-aio-nextcloud";
          REDIS_HOST = "nextcloud-aio-redis";
          REDIS_HOST_PASSWORD = "${cfg.redisPassword}";
          POSTGRES_HOST = "nextcloud-aio-database";
          POSTGRES_PASSWORD = "${cfg.databasePassword}";
          POSTGRES_DB = "nextcloud_database";
          POSTGRES_USER = "nextcloud";
        };

        volumes = [
          "nextcloud_aio_nextcloud:/nextcloud:ro"
        ];
      };

      nextcloud-aio-imaginary = {
        image = "nextcloud/aio-imaginary";

        autoStart = true;
        extraOptions = [
          "--network=nextcloud"
          "--read-only"
          "--read-only-tmpfs"
          "--cap-add=SYS_NICE"
        ];

        environment = {
          TZ = "${timezone}";
        };
      };

      nextcloud-aio-fulltextsearch = {
        image = "nextcloud/aio-fulltextsearch";

        autoStart = true;
        extraOptions = [
          "--network=nextcloud"
        ];

        environment = {
          TZ = "${timezone}";
          FULLTEXTSEARCH_PASSWORD = "${cfg.fulltextsearchPassword}";
          ES_JAVA_OPTS = "-Xms512M -Xmx512M";
          "bootstrap.memory_lock" = "true";
          "cluster.name" = "nextcloud-aio";
          "discovery.type" = "single-node";
          "logger.org.elasticsearch.discovery" = "WARN";
          "http.port" = "9200";
          "xpack.license.self_generated.type" = "basic";
          "xpack.security.enabled" = "false";
        };

        volumes = [
          "nextcloud_aio_elasticsearch:/usr/share/elasticsearch/data:rw"
        ];
      };
    };

    services.caddy.virtualHosts."nextcloud.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:11000

      encode gzip
    '';

    services.restic.backups.nextcloud = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/nextcloud_aio_nextcloud_data/_data"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
