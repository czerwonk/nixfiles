{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    bcc
    bpftrace
    dropwatch
    perf-tools
  ];
}
