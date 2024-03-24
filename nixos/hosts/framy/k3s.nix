{ pkgs, ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
  };

  environment.systemPackages = [ pkgs.k3s ];

  environment.persistence."/persist" = {
    directories = [
      "/etc/rancher"
    ];
  };

  networking.firewall.trustedInterfaces = [ "cni*" ];
}
