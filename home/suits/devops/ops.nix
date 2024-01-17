{ pkgs, ... }:

{
  imports = [
    ./kubernetes.nix
  ];

  home = {
    packages = with pkgs; [
      ansible
      ansible-role
      sshpass
      dns-drain
      provisionize
      vault
      terraform
      opentofu
      terrascan
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
