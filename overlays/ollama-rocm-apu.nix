self: super: {
  ollama-rocm = super.ollama-rocm.overrideAttrs (oldAttrs: rec {
    pname = "ollama-rocm-apu";
    version = "0.9.3";

    src = super.fetchFromGitHub {
      owner = "rjmalagon";
      repo = "ollama-linux-amd-apu";
      rev = "v${version}";
      # This hash needs to be updated when fetching
      hash = "sha256-h/VT/anJRmVRnD+n89/KkSiMy5Ft9N9YmjAesUBPpNo=";
    };

    # Additional build inputs or modifications may be needed
    # depending on the differences between the repositories
  });
}