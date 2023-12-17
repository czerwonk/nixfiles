{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
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
      perlPackages.JSONPP
      termshark
      mysql-shell
    ];
  };
}
