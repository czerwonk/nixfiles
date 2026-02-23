{ pkgs, ... }:

{
  environment.pathsToLink = [
    "share/thumbnailers"
  ];

  environment.systemPackages = with pkgs; [
    ffmpeg-headless
    ffmpegthumbnailer

    gdk-pixbuf
    # Allow gdk-pixbuf to thumbnail RAW photos by extracting the embedded jpeg
    (pkgs.writeTextFile {
      name = "raw-embedded-jpeg-thumbnailer";
      destination = "/share/thumbnailers/raw-embedded-jpeg.thumbnailer";
      text = ''
        [Thumbnailer Entry]
        TryExec=gdk-pixbuf-thumbnailer
        Exec=gdk-pixbuf-thumbnailer -s %s %u %o
        MimeType=image/x-canon-crw;image/x-canon-cr2;image/x-canon-cr3;image/x-adobe-dng;image/x-dng;
      '';
    })

    # For general HEIF container support (this includes the AVIF file format)
    libheif.bin # provides heif-thumbnailer (the program that generates HEIF thumbnails)
    libheif.out # provides heif.thumbnailer (allows for the viewing of HEIF thumbnails)

    # For more newer AVIF specific support usually not needed if libheif is installed
    libavif

    # For JXL(JPEG XL) support
    libjxl

    # For WebP support
    webp-pixbuf-loader
  ];
}
