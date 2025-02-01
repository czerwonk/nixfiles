{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "snacks.nvim";
  version = "v2.17.0";
  src = fetchFromGitHub {
    owner = "folke";
    repo = "snacks.nvim";
    rev = "bc39417e51649536f72bd9e850711663c125064f";
    sha256 = "16y78k5y1lci5y8laj35bx15b191sqh2igibxwp1dl90cp2c89f1";
  };
  meta.homepage = "https://github.com/folke/snacks.nvim/";
}
