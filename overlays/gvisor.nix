self: super: {
  gvisor = super.gvisor.overrideAttrs (old: {
    version = "20241210.0";
    src = super.fetchFromGitHub {
      owner = "google";
      repo = "gvisor";
      rev = "aa8ecac76a04b495181d784d84bf9ecc4e1fb876";
      hash = "sha256-sX3Er0IOXv+HCxQB0lU9oBMTlQJgaf8OJnpkWkFLnRQ=";
    };
    vendorHash = "sha256-cWMOmCgN+nXZh0X7ZXoguIiFVSXIJAbuuBWxysbgn6U=";
  });
}
