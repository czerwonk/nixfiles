{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "snacks.nvim";
  version = "v2.20.0";
  src = fetchFromGitHub {
    owner = "folke";
    repo = "snacks.nvim";
    rev = "76a5dcfb318d623022dada44c66453d9cb9a6eaa";
    sha256 = "sha256-YUjTuY47fWnHd9/z6WqFD0biW+wn9zLLsOVJibwpgKw=";
  };
  meta.homepage = "https://github.com/folke/snacks.nvim/";
}
