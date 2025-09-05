self: super: {
  ollama-rocm = super.ollama-rocm.overrideAttrs (oldAttrs: rec {
    pname = "ollama-rocm-apu";
    version = "0.11.8";

    src = super.fetchFromGitHub {
      owner = "rjmalagon";
      repo = "ollama-linux-amd-apu";
      rev = "v${version}";
      hash = "sha256-MwQqM1TBDcOemLrYU3AMqNYQwTb17sMrnPzriWrNc1c=";
    };
  });
}
