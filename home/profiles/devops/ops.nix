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
      provisionize
      redis
      termshark
      terrascan
      trurl
      vault
    ];
  };
}
