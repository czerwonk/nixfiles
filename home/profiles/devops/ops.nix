{ pkgs, ... }:

{
  imports = [
    ./kubernetes.nix
  ];

  home = {
    packages = with pkgs; [
      ansible
      ansible-role
      dns-drain
      google-cloud-sdk
      lynis
      mysql-shell
      opentofu
      perlPackages.JSONPP
      provisionize
      redis
      sshpass
      termshark
      terrascan
      trurl
      vault
    ];
  };
}
