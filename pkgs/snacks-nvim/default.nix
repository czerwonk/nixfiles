{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "snacks.nvim";
  version = "v2.22.0";
  src = fetchFromGitHub {
    owner = "folke";
    repo = "snacks.nvim";
    rev = "5eac729fa290248acfe10916d92a5ed5e5c0f9ed";
    sha256 = "sha256-iXfOTmeTm8/BbYafoU6ZAstu9+rMDfQtuA2Hwq0jdcE=";
  };
  meta.homepage = "https://github.com/folke/snacks.nvim/";
}
