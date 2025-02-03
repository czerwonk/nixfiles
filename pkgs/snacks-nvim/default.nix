{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "snacks.nvim";
  version = "v2.18.0";
  src = fetchFromGitHub {
    owner = "folke";
    repo = "snacks.nvim";
    rev = "43c884478d65e014ffd7dc04e32cdaa8305a7a28";
    sha256 = "sha256-90+LyldTortUMM7CpGZFH42QIP0efQhDshb6nw8pLXI=";
  };
  meta.homepage = "https://github.com/folke/snacks.nvim/";
}
