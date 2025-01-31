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
      grype
      hey
      inspec
      lynis
      mysql-shell
      net-merge
      openbao
      opentofu
      redis
      syft
      termshark
      terrascan
      trurl
    ];
  };
}
