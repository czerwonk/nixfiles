{ username, ... }:

{
  hardware.uinput.enable = true;
  users.users.${username}.extraGroups = [ "uinput" ];
}
