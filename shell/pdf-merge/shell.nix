{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    poppler_utils # pdfunite *.pdf output.pdf
    qpdf          # find -name '*.pdf' | xargs -I {} qpdf --decrypt "{}" --replace-input
  ];
}
