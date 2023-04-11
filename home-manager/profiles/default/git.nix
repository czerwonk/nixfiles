{ config, lib, pkgs, signingkey, ... }:

{
  programs.git = {
    userEmail = "daniel@routing.rocks";
  };
}
