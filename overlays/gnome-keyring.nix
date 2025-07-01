self: super: {
  gnome-keyring = super.gnome-keyring.overrideAttrs (oldAttrs: {
    configureFlags = oldAttrs.configureFlags or [ ] ++ [
      "--disable-ssh-agent"
    ];
  });
}
