{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.mastodon;
  version = "4.2.8";
  backup = pkgs.writeShellScriptBin "mastodon-db-backup" (builtins.readFile ./db-backup.sh);
  cleanup = pkgs.writeShellScriptBin "mastodon-cleanup" (builtins.readFile ./cleanup.sh);
  env = {
    RAILS_ENV = "production";
    LOCAL_DOMAIN = "routing.rocks";
    WEB_DOMAIN = "social.routing.rocks";
    SINGLE_USER_MODE = "true";
    SKIP_POST_DEPLOYMENT_MIGRATIONS = "true";

    DB_HOST = "mastodon-db";
    DB_PORT = "5432";
    DB_NAME = "postgres";
    DB_USER = "postgres";
    DB_PASS = "";

    REDIS_HOST = "mastodon-redis";
    REDIS_PORT = "6379";
    REDIS_PASSWORD = "";

    ES_ENABLED = "true";
    ES_HOST = "mastodon-es";
    ES_PORT = "9200";

    VAPID_PUBLIC_KEY = "BDSxNZhhbdxNTKBfSdhdHQG9Dh0n0id2447p8h3bN46hLMcFNJCnxdQ0wn5iiOME2b5DReqcT2h8PibOFUmdajg=";
    VAPID_PRIVATE_KEY = "${cfg.vapipPrivateKey}";
    SECRET_KEY_BASE = "${cfg.secretKeyBase}";
    OTP_SECRET = "${cfg.otpSecret}";
  };

in {
  options = {
    my.services.mastodon = {
      enable = mkEnableOption "Mastodon";

      vapipPrivateKey = mkOption {
        type = types.str;
      };

      secretKeyBase = mkOption {
        type = types.str;
      };

      otpSecret = mkOption {
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.podman-create-mastodon-pod = {
      serviceConfig.Type = "oneshot";
      wantedBy = [
        "podman-mastodon-web.service"
        "podman-mastodon-db.service"
        "podman-mastodon-redis.service"
        "podman-mastodon-es.service"
        "podman-mastodon-streaming.service"
        "podman-mastodon-sidekiq.service"
      ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists mastodon || podman network create mastodon
      '';
    };

    virtualisation.oci-containers.containers = {
      mastodon-db = {
        image = "postgres:14-alpine";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=mastodon"
          "--shm-size=268435456"
        ];

        environment = {
          POSTGRES_HOST_AUTH_METHOD = "trust";
        };

        volumes = [
          "mastodon_postgresql-data:/var/lib/postgresql/data"
        ];
      };

      mastodon-redis = {
        image = "redis:7-alpine";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=mastodon"
        ];

        volumes = [
          "mastodon_redis-data:/data"
        ];
      };

      mastodon-web = {
        image = "ghcr.io/mastodon/mastodon:v${version}";
        cmd = [ "bundle" "exec" "puma" "-C" "config/puma.rb" ];

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=mastodon"
        ];

        environment = env;

        volumes = [
          "mastodon_system-data:/opt/mastodon/public/system"
        ];

        dependsOn = [
          "mastodon-db"
          "mastodon-redis"
          "mastodon-es"
        ];

        ports = [
          "127.0.0.1:3000:3000"
        ];
      };

      mastodon-streaming = {
        image = "ghcr.io/mastodon/mastodon:v${version}";
        cmd = [ "node" "./streaming" ];

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=mastodon"
        ];

        environment = env;

        dependsOn = [
          "mastodon-db"
          "mastodon-redis"
        ];
      };

      mastodon-sidekiq = {
        image = "ghcr.io/mastodon/mastodon:v${version}";
        cmd = [ "bundle" "exec" "sidekiq" ];

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=mastodon"
          "--cap-add=NET_BIND_SERVICE"
        ];

        environment = env;

        volumes = [
          "mastodon_system-data:/opt/mastodon/public/system"
        ];

        dependsOn = [
          "mastodon-db"
          "mastodon-redis"
        ];
      };

      mastodon-es = {
        image = "docker.elastic.co/elasticsearch/elasticsearch:7.17.4";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=mastodon"
          "--ulimit=memlock=-1:-1"
          "--ulimit=nofile=65536:65536"
        ];

        environment = {
          ES_JAVA_OPTS = "-Xms512m -Xmx512m -Des.enforce.bootstrap.checks=true";
          "xpack.license.self_generated.type" = "basic";
          "xpack.security.enabled" = "false";
          "xpack.watcher.enabled" = "false";
          "xpack.graph.enabled" = "false";
          "xpack.ml.enabled" = "false";
          "bootstrap.memory_lock" = "true";
          "cluster.name" = "es-mastodon";
          "discovery.type" = "single-node";
          "thread_pool.write.queue_size" = "1000";
        };

        volumes = [
          "mastodon_elasticsearch-data:/usr/share/elasticsearch/data"
        ];
      };
    };

    systemd.timers = {
      mastodon-db-backup = {
        timerConfig = {
          Unit = "mastodon-db-backup.service";
          OnCalendar = "*-*-* 00:00:00";
        };
        wantedBy = [ "timers.target" ];
        partOf = [ "mastodon-db-backup.service" ];
      };
      mastodon-cleanup = {
        timerConfig = {
          Unit = "mastodon-cleanup.service";
          OnCalendar = "*-*-* 01:00:00";
        };
        wantedBy = [ "timers.target" ];
        partOf = [ "mastodon-cleanup.service" ];
      };
    };

    systemd.services = {
      mastodon-db-backup = {
        description = "Mastodon Database Backup";
        path = with pkgs; [
          podman
          gzip
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${backup}/bin/mastodon-db-backup";
        };
      };
      mastodon-cleanup = {
        description = "Mastodon Clenup Tasks";
        path = with pkgs; [
          podman
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${cleanup}/bin/mastodon-cleanup";
        };
      };
    };

    services.caddy.virtualHosts."routing.rocks".extraConfig = lib.mkAfter ''
      redir /.well-known/host-meta https://social.routing.rocks{uri}
      redir /.well-known/webfinger https://social.routing.rocks{uri}
    '';

    services.caddy.virtualHosts."social.routing.rocks".extraConfig = ''
      reverse_proxy * 127.0.0.1:3000

      encode gzip
    '';

    services.restic.backups.mastodon = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/mastodon_system-data/_data/"
        "/var/lib/containers/storage/volumes/mastodon_redis-data/_data/dump.rdb"
        "/data/backup/mastodon"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
