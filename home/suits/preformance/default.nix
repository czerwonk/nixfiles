{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bcc
      bpftrace
      fio
      hey
      sysbench
    ];
  };
}
