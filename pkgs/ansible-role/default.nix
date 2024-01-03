{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule {
  pname = "ansible-role";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "czerwonk";
    repo = "ansible-role";
    rev = "bc855becba0b0d5a15b9237b8f72930de3b760b6";
    hash = "sha256-ZYscP10tldzlJSAJMiSXZKPHKMLospyYKQ7v/Du5quo=";
  };

  vendorHash = null;

  CGO_ENABLED = 0;

  meta = with lib; {
    description = "This is a simple wrapper for Ansible to run a single role without the need to generate a playbook first.";
    homepage = "https://github.com/czerwonk/ansible-role";
    license = licenses.mit;
  };
}
