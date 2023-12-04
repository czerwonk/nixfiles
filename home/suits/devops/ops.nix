{ pkgs-unstable, ... }:

{
  home = {
    packages = with pkgs-unstable; [
      ansible
      vault
      terraform
      terrascan
      kubectl
      k9s
      kubernetes-helm
      krew
      kubetail
      google-cloud-sdk
      redis
      hey
      lynis
      mysql-shell
      perlPackages.JSONPP
    ];
  };
}
