{
  imports = [
    ../common.nix
    ./theme.nix
  ];

  services.gpg-agent.pinentryFlavor = "gnome3";
}
