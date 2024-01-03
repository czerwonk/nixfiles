{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule {
  pname = "dns-drain";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "czerwonk";
    repo = "dns-drain";
    rev = "7a70f17246842215c75cc9084ec7ccb010bde2a5";
    hash = "sha256-GQj7DFsgBI7wTVQe2w56uxeqLWkbA5rOXQMy43uOTEk=";
  };

  subPackages = [ "cmd/dns-drainctl" ];

  vendorHash = "sha256-RjzSIYoFylKLmN++6vIngBJOUjTlO14mOf7bvk56jGo=";

  CGO_ENABLED = 0;

  meta = with lib; {
    description = "Drain by removing/replacing IP/net from DNS records with ease.";
    homepage = "https://github.com/czerwonk/dns-drain";
    license = licenses.mit;
  };
}
