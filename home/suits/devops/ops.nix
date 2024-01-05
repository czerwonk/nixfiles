{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ansible
      ansible-role
      dns-drain
      provisionize
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
      python311Packages.pywinrm
    ];
  };
}
