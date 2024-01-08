{ lib
, stdenvNoCC
, fetchFromGitHub
, python3
, pkgs
, routing-rocks-vars
}:

stdenvNoCC.mkDerivation {
  pname = "routing-rocks-policy";
  version = "2.1.17";

  src = fetchFromGitHub {
    owner = "czerwonk";
    repo = "routing-rocks-policy-role";
    rev = "2.1.17";
    hash = "sha256-8CqGyapPkxfx9QKSgCUYfd7JMU1bT4CR0mSIYXYriKw=";
  };

  buildInputs = [
    pkgs.ansible
    python3
  ];

  dontBuild = true;

  varfile = pkgs.writeText "vars.yml" routing-rocks-vars;

  playbookfile = pkgs.writeText "playbook.yml" (builtins.readFile ./playbook.yml);

  installPhase = ''
    runHook preInstall
    export HOME=$(pwd)
    mkdir -p $out
    ${pkgs.ansible}/bin/ansible-playbook -i . -e @$varfile -e bird_config_dir=$out $playbookfile
    runHook postInstall
  '';

  meta = with lib; {
    description = "routing-rocks routing policy";
    homepage = "https://github.com/czerwonk/routing-rocks-policy-role";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
