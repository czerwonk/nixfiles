{ pkgs, lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/server
    ../../suits/container
    ../../suits/routing
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.postDeviceCommands = lib.mkBefore ''
    mkdir -p /btrfs_mnt
    mount -o subvol=/ /dev/disk/by-uuid/96ea7ea2-62e9-47bd-a935-4b1bcdfc2229 /btrfs_mnt
    echo "Delete old root subvolume..."
    btrfs subvolume list -o /btrfs_mnt/root |
      cut -f 9 -d ' ' |
      while read subvolume; do
        echo "Delete subvolume $subvolume..."
        btrfs subvolume delete "/btrfs_mnt/$subvolume"
      done
    btrfs subvolume delete /btrfs_mnt/root
    echo "Create new root subvolume..."
    btrfs subvolume create /btrfs_mnt/root
    umount /btrfs_mnt
  '';

  services.caddy = {
    enable = true;
    adapter = "caddyfile";
    configFile = pkgs.writeText "Caddyfile" ''
      routing.rocks {
        redir /.well-known/host-meta https://social.routing.rocks{uri}
        redir /.well-known/webfinger https://social.routing.rocks{uri}
        root * /var/www

        encode gzip
        log {
          output file /var/log/caddy/access.log {
            roll_keep 4
            roll_keep_for 7d
          }
        }
        tls {
          protocols tls1.2 tls1.3
        }
      }

      social.routing.rocks {
        reverse_proxy * 127.0.0.1:3000

        encode gzip
        log {
          output file /var/log/caddy/access.log {
            roll_keep 4
            roll_keep_for 7d
          }
        }
        tls {
          protocols tls1.2 tls1.3
        }
      }
    '';
  };
}
