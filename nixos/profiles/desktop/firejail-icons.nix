{ pkgs, lib, ... }:

{
  environment.systemPackages = [
    (
      let packages = with pkgs; [
        chromium
        firefox
        teams-for-linux
        thunderbird
      ];

      in
        pkgs.runCommand "firejail-icons" {
          preferLocalBuild = true;
          allowSubstitutes = false;
          meta.priority = -1;
        } ''
          mkdir -p "$out/share/icons"
          ${lib.concatLines (map (pkg: ''
            tar -C "${pkg}" -c share/icons -h --mode 0755 -f - | tar -C "$out" -xf -
          '') packages)}
          find "$out/" -type f -print0 | xargs -0 chmod 0444
          find "$out/" -type d -print0 | xargs -0 chmod 0555
        ''
    )
  ];
}
