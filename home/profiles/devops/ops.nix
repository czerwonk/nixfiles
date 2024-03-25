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
      inspec
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
