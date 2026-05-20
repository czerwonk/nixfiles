{
  imports = [
    ./danalog-pics.nix
  ];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/www"
    ];
  };
}
