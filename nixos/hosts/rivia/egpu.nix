{ pkgs, username, ... }:

{
  users.users.${username}.packages = [ pkgs.all-ways-egpu ];
}
