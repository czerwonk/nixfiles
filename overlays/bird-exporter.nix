# TODO: remove once nixpkgs ships bird-exporter >= 1.7.2
self: super: {
  prometheus-bird-exporter = super.prometheus-bird-exporter.overrideAttrs (
    finalAttrs: oldAttrs: {
      version = "1.7.2";

      src = super.fetchFromGitHub {
        owner = "czerwonk";
        repo = "bird_exporter";
        tag = "v${finalAttrs.version}";
        hash = "sha256-JwzC+XVHT91qRHSSk8ARwKhlz8wK88MB1SpJ0+Bb7cc=";
      };

      vendorHash = "sha256-u5dNhZal7YwRYBaR4+1P5MloDzeIDVMRQhcm7Q+Lkeo=";
    }
  );
}
