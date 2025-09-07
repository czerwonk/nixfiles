{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      (ruby.withPackages (ps: with ps; [ rubyPackages.mysql2 ]))
      solargraph
    ];
  };
}
