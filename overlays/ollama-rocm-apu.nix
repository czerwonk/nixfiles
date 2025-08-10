self: super: {
  ollama-rocm = super.ollama-rocm.overrideAttrs (oldAttrs: rec {
    pname = "ollama-rocm-apu";
    version = "0.11.3";

    src = super.fetchFromGitHub {
      owner = "rjmalagon";
      repo = "ollama-linux-amd-apu";
      rev = "v${version}";
      hash = "sha256-ol0ivSd2O6CVlc3ki/tDOVePt5mWWyGyYAobmSKGPSE=";
    };
  });
}

