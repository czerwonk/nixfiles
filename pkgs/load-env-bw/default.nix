{ pkgs, lib, ... }:

pkgs.writeShellScriptBin "load-env-bw" ''
  filter='.notes'

  if [ ! -z "$2" ]; then
    filter="$2"
  fi

  ${lib.getExe pkgs.bitwarden-cli} get item "$1" | jq -r "$filter"
''
