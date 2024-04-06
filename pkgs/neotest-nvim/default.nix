{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "neotest";
  version = "2024-03-20";
  src = fetchFromGitHub {
    owner = "nvim-neotest";
    repo = "neotest";
    rev = "d424d262d01bccc1e0b038c9a7220a755afd2a1f";
    sha256 = "1sg8m77hik1gffrqy4038sivhr8yhg536dp6yr5gbnbrjvc35dgm";
  };
  meta.homepage = "https://github.com/nvim-neotest/neotest/";
}
