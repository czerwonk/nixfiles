{ pkgs, ... }:

{
  imports = [
    ./kubernetes.nix
  ];

  home = {
    packages = with pkgs; [
      ansible
      ansible-lint
      ansible-role
      dns-drain
      google-cloud-sdk
      hey
      inspec
      lynis
      mysql-shell
      net-merge
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
