{ lib
, stdenvNoCC
, fetchFromGitHub
, python3
, pkgs
, vars
, as-sets
}:

stdenvNoCC.mkDerivation {
  pname = "routing-rocks-policy";
  version = "2.1.17";

  src = fetchFromGitHub {
    owner = "czerwonk";
    repo = "routing-rocks-policy-role";
    rev = "988660101c65adf70ffc0f16a2ac537f24fc56fd";
    hash = "sha256-6TLUYd2OPKWQDnQuJxbUCV4mXg5aNrl3gsJaUGZJVEg=";
  };

  buildInputs = [
    pkgs.ansible
    python3
  ];

  dontBuild = true;

  as_set_file = pkgs.writeText "as-sets.conf" as-sets;

  var_file = pkgs.writeText "vars.yml" vars;

  installPhase = ''
    runHook preInstall
    export HOME=$(pwd)
    export ANSIBLE_REMOTE_TEMP="/tmp/.ansible"
    mkdir -p $out
    ${pkgs.ansible}/bin/ansible -c local -m include_role -a "name=$(pwd)" -e @$var_file \
      -e bird_config_dir=$out -e skip_handler=true -e owner=$(whoami) localhost
    cp $as_set_file $out/bird.d/as-sets/as-sets.conf
    runHook postInstall
  '';

  meta = with lib; {
    description = "routing-rocks routing policy";
    homepage = "https://github.com/czerwonk/routing-rocks-policy-role";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
