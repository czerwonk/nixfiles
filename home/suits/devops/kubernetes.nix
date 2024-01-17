{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      kubectl
      k9s
      kubernetes-helm
      krew
      stern
    ];
  };

  programs.zsh.shellAliases = {
    k = "${pkgs.kubectl}/bin/kubectl";
    kexec = "${pkgs.kubectl}/bin/kubectl exec -it";
    klog = "${pkgs.kubectl}/bin/kubectl logs";
  };
}
