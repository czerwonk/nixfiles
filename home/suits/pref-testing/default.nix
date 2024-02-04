{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      fio
      sysbench
    ];
  };
}
