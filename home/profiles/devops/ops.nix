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
      dive
      dns-drain
      google-cloud-sdk
      grype
      hyperfine
      inspec
      lynis
      mysql-shell
      net-merge
      opentofu
      syft
      termshark
      terrascan
      trurl
      vegeta
    ];
  };
}
