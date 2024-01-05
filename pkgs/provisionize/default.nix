{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule {
  pname = "provisionize";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "MauveSoftware";
    repo = "provisionize";
    rev = "f78bf9409c32c07de7e64e44b6649bf34f4dd7cf";
    hash = "sha256-3NrivV95hGkW6f2npBQxoWdFK04vtIWcEauUag/NOHQ=";
  };

  subPackages = [
    "cmd/provisionizer"
    "cmd/deprovisionizer"
  ];

  vendorHash = "sha256-cf9lFLHccQbROvnjriI1AmNizwlfzUPd/5c7efMXMcQ=";

  CGO_ENABLED = 0;

  meta = with lib; {
    description = "Zero touch provisioning for oVirt VMs with Google Cloud DNS integration";
    homepage = "https://github.com/MauveSoftware/provisionize";
    license = licenses.mit;
  };
}
