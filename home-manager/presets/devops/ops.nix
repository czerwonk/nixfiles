{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ansible
      kubectl
      vault
      terraform
      tflint
      k9s
      kubernetes-helm
      krew
      google-cloud-sdk
      redis
      siege
      lynis
    ];
  };
}
