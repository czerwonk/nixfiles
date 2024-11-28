{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/osx
  ] ++ extraHomeModules;
}
