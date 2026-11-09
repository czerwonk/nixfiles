{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      dotnet-sdk_10
      dotnet-aspnetcore_10
      omnisharp-roslyn
    ];
  };
}
