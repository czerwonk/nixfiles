{ pkgs, ... }:

{
  services.gpg-agent.pinentry.package = pkgs.pinentry-gtk2;
}
