{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      delve
      go
      protobuf
      protoc-gen-go
      protoc-gen-go-grpc
    ];
    sessionVariables = {
      CGO_ENABLED = "1";
    };
  };
}
