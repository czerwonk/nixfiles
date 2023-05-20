{ pkgs, username, hostname, ... }:

{
  imports = [
    ./hardening.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = hostname;
  networking.nameservers = [ "1.1.1.1" "2606:4700:4700::1111" "8.8.8.8" ];
  networking.networkmanager = {
    enable = true;
    dns = "none";
  };
  services.ntp.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };
  console.useXkbConfig = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.${username} = {
    isNormalUser = true;
    description = "Daniel Czerwonk";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCntn+hhu24ebIaemRkZehp57IxFcOIwAfD6lELC1REZpHWEgZ685xiqJPai5Gp9gt17oAut1FEayJd6ZOYKPXNDS1Bm6E0EDSVpVHUPiVivcfYMSmRknti5I+BnkJRzy79gbN66e5TByzVir1gIqJSEorfYyA4rx3DFDtFtl6Bbq1UswR/g4RowxIAwMjj8MYesOw612khRg53fxOMniVpsd9ULqstBg1iOvfkKJhoU7pyYkZWIkka96cLcuw6ZX+u18is5eTrldo6oRT7A6ujgDy6wpJ3dvDR0EK12koBMcwrwcYeQyCHUzR4Bo89gXtRfLeHSjW2vUXPm+OXsu31Hb50KH+M/CPGXOUDBS//8vqVv3QZ02sbcFLxZiOPEPnKfruqakWNE9iYHQDa521YQj/XKJ73AytAym/vqzK5usqmQpSUM3D0fWWAec75n4EG9rUMVJ4WzkYI30uqkp7gzBWD0aeFPVY7dVUVTx8+iiTTft7JnTzkFxdUxm7s0cZMKYPqNpeYDfS1OyFnw1HjHMXnOCDoEKM7DUu7ioGu5CrkqjwsmqHHSQS9CVc9qQNebYIyOu6oL1mDbxGf5bZlkGMECAnkaFYNEwJF2IACzLVpM3txSGdX2GqgM/4kU9mce4gmzt6Pz+0LP3TF9oT8voRQ3KTnSuRv1PrBXzx2RQ=="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDC5NEvD6tPxgg2MrQpJz6bl0gac3iJEJ6FKT2yebj5aYP30lTogZiyCTfTls30SkeNKfUkEjlIrF6ShfVcry/VTsZyARXYCv1NJcvdHcpvuufvuhlfzhmD0vnp/VVZbhuLyILzBOdGjJ7eBT886m3GkOG1EYw7HA+XZFLbrEdQMcASSBQaULhhWSZI0s1W8hiG7Jg8cMdgjJkhQALTKkfOmV/FzZ4ZS6OLspBrPxUxIwKUyYhGJ54KCvhQ8eV3av7x87cwMUc/gBhpI2upq86U+wVSBPkUt1GNHrQLVpAQ5cBut4BhKMU9w+B71TEIcPSSNwy3Efv5x3gSkGEDzU2AVc0KQyBTs38IWGB1UXEGTtbVI9JzAoDNJjjGXqOClgLc7Quyv58CabzhlELtPUtIqoRJGggiwhYJ7oiPbNkBDe+AfIWIbCwIunShmxQA+5oeAuZGOgLCPoryyjzyvKHx4W/jESvbji3YACZ2362UcoJOx6yNlE6Bhvo8+y3fUvjQjqgOXR2siMWVUuhXfzJsFYMBtA2R5NgqioWqveGmgBbeW+mG/X91f09ZEm5Edn6VYK4FAGJFizVdadp15KlgUPFUuS+6q/i5rXMjeQCnC6anXjPHJQpSYgmoZjjgI9WUGkGoqwSxmCfgEBg5rI9JW38TqEt0Z4gjZ6ViRee2Sw=="
    ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gnupg
    gitFull
    vim 
    wget
    unzip
    wireguard-tools
    lsof
  ];
  environment.shells = [ pkgs.zsh ];

  system.stateVersion = "22.11";
 }
