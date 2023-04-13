{ config, pkgs, extraHomeModules, lib, ... }:

{
  imports = [
    ../../home-manager/linux.nix
    ../../home-manager/presets/desktop
    ../../home-manager/programs/vscode
  ] ++ extraHomeModules;

  programs.git = {
    extraConfig = {
      user.signingKey = lib.mkForce "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCntn+hhu24ebIaemRkZehp57IxFcOIwAfD6lELC1REZpHWEgZ685xiqJPai5Gp9gt17oAut1FEayJd6ZOYKPXNDS1Bm6E0EDSVpVHUPiVivcfYMSmRknti5I+BnkJRzy79gbN66e5TByzVir1gIqJSEorfYyA4rx3DFDtFtl6Bbq1UswR/g4RowxIAwMjj8MYesOw612khRg53fxOMniVpsd9ULqstBg1iOvfkKJhoU7pyYkZWIkka96cLcuw6ZX+u18is5eTrldo6oRT7A6ujgDy6wpJ3dvDR0EK12koBMcwrwcYeQyCHUzR4Bo89gXtRfLeHSjW2vUXPm+OXsu31Hb50KH+M/CPGXOUDBS//8vqVv3QZ02sbcFLxZiOPEPnKfruqakWNE9iYHQDa521YQj/XKJ73AytAym/vqzK5usqmQpSUM3D0fWWAec75n4EG9rUMVJ4WzkYI30uqkp7gzBWD0aeFPVY7dVUVTx8+iiTTft7JnTzkFxdUxm7s0cZMKYPqNpeYDfS1OyFnw1HjHMXnOCDoEKM7DUu7ioGu5CrkqjwsmqHHSQS9CVc9qQNebYIyOu6oL1mDbxGf5bZlkGMECAnkaFYNEwJF2IACzLVpM3txSGdX2GqgM/4kU9mce4gmzt6Pz+0LP3TF9oT8voRQ3KTnSuRv1PrBXzx2RQ==";
    };
  };
}
