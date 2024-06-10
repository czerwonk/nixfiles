{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    fio
    sysbench
    (pkgs.writeShellScriptBin "run-fileio" ''
      mode=$1
      if [ "$1" = "" ]; then
        mode="rndrw"
      fi

      sysbench fileio --file-total-size=10G --file-num=512 prepare
      sysbench fileio --num-threads=1 --file-total-size=10G --file-num=512 --file-test-mode=$mode --time=300 --max-requests=0 --file-extra-flags=direct --file-fsync-freq=1 run
      sysbench fileio --file-total-size=10G --file-num=512 cleanup 1> /dev/null
    '')
  ];
}
