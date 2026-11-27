{ pkgs, ... }:

{
  imports = [
    ./kubernetes.nix
  ];

  home = {
    packages = with pkgs; [
      age
      ansible
      ansible-lint
      ansible-role
      crane
      gitleaks
      google-cloud-sdk
      grype
      hyperfine
      inspec
      lynis
      mysql-shell
      net-reduce
      opentofu
      sops
      syft
      termshark
      terrascan
      vegeta
    ];
  };

  programs.secretspec.enable = true;
}
