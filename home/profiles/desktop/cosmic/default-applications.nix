{
  xdg.mimeApps.defaultApplications = {
    # browser
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";

    # mail & calendar
    "x-scheme-handler/mailto" = "thunderbird.desktop";
    "message/rfc822" = "thunderbird.desktop";
    "x-scheme-handler/mid" = "thunderbird.desktop";
    "x-scheme-handler/webcal" = "thunderbird.desktop";
    "x-scheme-handler/webcals" = "thunderbird.desktop";
    "text/calendar" = "thunderbird.desktop";
    "application/x-extension-ics" = "thunderbird.desktop";

    # chat & app links
    "x-scheme-handler/msteams" = "teams-for-linux.desktop";
    "x-scheme-handler/bruno" = "bruno.desktop";

    # office documents
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
    "application/vnd.oasis.opendocument.text" = "writer.desktop";
    "application/pdf" = "com.system76.CosmicReader.desktop";

    # text
    "text/plain" = "com.system76.CosmicEdit.desktop";
    "text/x-lua" = "com.system76.CosmicEdit.desktop";
    "application/x-zerosize" = "com.system76.CosmicEdit.desktop";

    # images
    "image/jpeg" = "com.xnview.XnViewMP.desktop";
    "image/heif" = "com.xnview.XnViewMP.desktop";
    "image/x-adobe-dng" = "com.xnview.XnViewMP.desktop";
    "image/x-canon-cr3" = "com.xnview.XnViewMP.desktop";

    # ebooks
    "application/epub+zip" = "com.calibre_ebook.calibre.ebook-viewer.desktop";
    "application/x-mobipocket-ebook" = "com.calibre_ebook.calibre.ebook-viewer.desktop";

    # video
    "video/mp4" = "com.system76.CosmicPlayer.desktop";
    "video/x-matroska" = "com.system76.CosmicPlayer.desktop";
    "video/webm" = "com.system76.CosmicPlayer.desktop";
    "video/quicktime" = "com.system76.CosmicPlayer.desktop";
    "video/mpeg" = "com.system76.CosmicPlayer.desktop";
    "video/x-msvideo" = "com.system76.CosmicPlayer.desktop";
    "video/x-ms-wmv" = "com.system76.CosmicPlayer.desktop";
    "video/3gpp" = "com.system76.CosmicPlayer.desktop";
    "video/3gpp2" = "com.system76.CosmicPlayer.desktop";
    "video/ogg" = "com.system76.CosmicPlayer.desktop";
    "video/x-flv" = "com.system76.CosmicPlayer.desktop";
  };
}
