{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      delve
      go
      gopls
      govulncheck
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
    ];
    sessionVariables = {
      CGO_ENABLED = "1";
    };
  };
}
