{ pkgs, fetchFromGitHub, lib }:

pkgs.vimUtils.buildVimPlugin {
  pname = "snacks.nvim";
  version = "v2.21.0";
  src = fetchFromGitHub {
    owner = "folke";
    repo = "snacks.nvim";
    rev = "51542bb8f43cbd0ca9d2ff3c5ad8a86fd76475a1";
    sha256 = "sha256-COvKNofUMiNV9MZvP18dtmkNSMXeTlumN2sIeBl4VqE=";
  };
  meta.homepage = "https://github.com/folke/snacks.nvim/";
}
