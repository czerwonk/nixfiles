{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "snacks.nvim";
  version = "v2.17.0";
  src = fetchFromGitHub {
    owner = "folke";
    repo = "snacks.nvim";
    rev = "2db89fbdd8cbec5a383529c5435500032f4c1206";
    sha256 = "sha256-9VzolCXQdKui45mafxm5uZtk9nOns4jPky4Kgn3kXZs=";
  };
  meta.homepage = "https://github.com/folke/snacks.nvim/";
}
