{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ansible
      kubectl
      vault
      terraform
      terrascan
      k9s
      kubernetes-helm
      krew
      google-cloud-sdk
      redis
      siege
      lynis
      mysql-shell
      perlPackages.JSONPP
    ];
  };
}
