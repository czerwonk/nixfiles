{
  services.flatpak.enable = true;

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  services.flatpak.packages = [
    "com.bitwarden.desktop"
    "com.calibre_ebook.calibre"
    "com.discordapp.Discord"
    "com.mattermost.Desktop"
    "com.xnview.XnViewMP"
  ];

  services.flatpak.update.onActivation = true;
}
