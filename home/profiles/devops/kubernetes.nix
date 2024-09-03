{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      k9s
      krew
      kubectl
      kubernetes-helm
      kubevirt
      stern
      trivy
    ];
  };

  programs.zsh.shellAliases = {
    k = "${pkgs.kubectl}/bin/kubectl";
    kexec = "${pkgs.kubectl}/bin/kubectl exec -it";
    klog = "${pkgs.kubectl}/bin/kubectl logs";
  };
}
