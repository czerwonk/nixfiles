{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "snacks.nvim";
  version = "v2.19.0";
  src = fetchFromGitHub {
    owner = "folke";
    repo = "snacks.nvim";
    rev = "789f161de12021b9304dc36231283a8b2ecabbe9";
    sha256 = "sha256-+Af4epvkGStCv2tlWWoI2MZSCNafkpgVahUlkrt9fmc=";
  };
  meta.homepage = "https://github.com/folke/snacks.nvim/";
}
