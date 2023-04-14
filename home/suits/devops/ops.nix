{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ansible
      ansible-lint
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
