{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      delve
      go
      gopls
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
    ];
    sessionVariables = {
      CGO_ENABLED = "1";
    };
  };
}
