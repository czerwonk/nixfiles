{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs.python313Packages; [
    huggingface-hub
    llama-cpp-python
  ];
}
