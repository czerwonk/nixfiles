{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs.python313Packages; [
    gguf
    huggingface-hub
    llama-cpp-python
    torch
    transformers
  ];
}
