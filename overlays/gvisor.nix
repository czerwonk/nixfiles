self: super: {
  gvisor = super.gvisor.overrideAttrs (old: {
    version = "20250804.0";
    src = super.fetchFromGitHub {
      owner = "google";
      repo = "gvisor";
      rev = "67b57f6fa0dea8c677c05d1a874dbcf2361f9bd1";
      hash = "sha256-sX3Er0IOXv+HCxQB0lU9oBMTlQJgaf8OJnpkWkFLnRQ=";
    };
    vendorHash = "sha256-MAWqGtv89Wc8LWqrrEZpEkrxHYOpUnDUkBF50nfOkiI=";
  });
}
