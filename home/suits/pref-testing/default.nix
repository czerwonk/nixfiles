{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      fio
      hey
      sysbench
    ];
  };
}
