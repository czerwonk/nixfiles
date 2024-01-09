{ lib
, rustPlatform
, fetchFromGitHub
, installShellFiles
, mandown
, protobuf
, go-md2man
, nixosTests
}:

rustPlatform.buildRustPackage rec {
  pname = "netavark";
  version = "1.9.0";

  src = fetchFromGitHub {
    owner = "containers";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-8uuGM6WT9WHs86NSb+jS/I4kGZpIBXPGH+scjqOyzos=";
  };

  cargoHash = "sha256-U8W6JzMfRbARGtryjorQvCq0Z3Ual1hTdc19mex7oSE=";

  nativeBuildInputs = [ installShellFiles mandown protobuf go-md2man ];

  postBuild = ''
    make -C docs netavark.1
    installManPage docs/netavark.1
  '';

  passthru.tests = { inherit (nixosTests) podman; };

  meta = with lib; {
    changelog = "https://github.com/containers/netavark/releases/tag/${src.rev}";
    description = "Rust based network stack for containers";
    homepage = "https://github.com/containers/netavark";
    license = licenses.asl20;
    platforms = platforms.linux;
  };
}
