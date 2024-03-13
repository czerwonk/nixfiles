{ lib, buildGo122Module, fetchFromGitHub }:

buildGo122Module rec {
  pname = "ethr";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "czerwonk";
    repo = pname;
    rev = "f385bedbb0c683a31afadbdaec4f7e0c4c3781be";
    hash = "sha256-Xp8Z4eBKDV0T1k0tc7RVl+lvAfwDEM7Klf04wxpEgs8=";
  };

  vendorHash = "sha256-U7+oiFlsrhgGMJYtgZEzonnogoHdJmJC1m82krmPOlc=";

  meta = with lib; {
    homepage = "https://github.com/microsoft/ethr";
    description = "Ethr is a cross platform network performance measurement tool written in golang";
    license = licenses.mit;
  };
}
