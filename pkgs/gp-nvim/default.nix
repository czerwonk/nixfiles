{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "gp.nvim";
  version = "v3.9.0";
  src = fetchFromGitHub {
    owner = "Robitx";
    repo = "gp.nvim";
    rev = "e6a01e9788dbc7c09df6ffe47b6d15d1cb455de8";
    sha256 = "3tfhahQZPBYbAnRQXtMAnfwr4gH7mdjxtB8ZqrU3au4=";
  };
  meta.homepage = "https://github.com/Robitx/gp.nvim";
}
