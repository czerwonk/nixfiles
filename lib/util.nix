{
  readDirString = dir:
    let
      files = builtins.readDir dir;
      contents = map (file: builtins.readFile "${dir}/${file}") (builtins.attrNames files);
    in
      builtins.concatStringsSep "\n\n" contents;
}
