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
      opentofu
      terrascan
      google-cloud-sdk
      redis
      lynis
      perlPackages.JSONPP
      termshark
      mysql-shell
    ];
  };
}
