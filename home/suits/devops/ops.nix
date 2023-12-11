{ pkgs-unstable, ... }:

{
  home = {
    packages = with pkgs-unstable; [
      ansible
      vault
      terraform
      opentofu
      terrascan
      kubectl
      k9s
      kubernetes-helm
      krew
      stern
      google-cloud-sdk
      redis
      hey
      lynis
      mysql-shell
      perlPackages.JSONPP
      termshark
    ];
  };
}
