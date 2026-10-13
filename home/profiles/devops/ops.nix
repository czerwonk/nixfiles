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
      google-cloud-sdk
      grype
      hyperfine
      inspec
      lynis
      mysql-shell
      net-reduce
      opentofu
      syft
      termshark
      terrascan
      vegeta
    ];
  };
}
