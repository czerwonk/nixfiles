{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ansible
      ansible-language-server
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
