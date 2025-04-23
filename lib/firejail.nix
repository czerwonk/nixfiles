# originated from https://github.com/VAWVAW/nixos-lib/blob/main/lib/firejail.nix
let
  script = {
    relativePath,
    firejailBinary,
    firejailArgs,
    ...
  }: ''
    (
      local prog="$out${relativePath}"
      local hidden firejail

      assertExecutable "$prog"

      hidden="$(dirname "$prog")/.$(basename "$prog")"-wrapped
      while [ -e "$hidden" ]; do
        hidden="''${hidden}_"
      done
      mv "$prog" "$hidden"

      # ignore check
      assertExecutable() {
        :
      }

      firejail="${firejailBinary}\" ${firejailArgs} \"$hidden"

      makeShellWrapper "$firejail" "$prog"
    )
  '';

  wrapPhase = {
    package,
    makeWrapper,
    lib,
    ...
  } @ args: let
    ensureElem = list: elem: list ++ (lib.optional (!builtins.elem elem list) elem);
  in
    package.overrideAttrs (
      old:
        {
          nativeBuildInputs = ensureElem (old.nativeBuildInputs or []) makeWrapper;

          postPhases = ensureElem (old.postPhases or []) "wrapFirejailPhase";

          wrapFirejailPhase = (old.wrapFirejailPhase or "") + (script args);

          doInstallCheck =
            lib.warnIf (
              old.doInstallCheck or false
            ) "disabeling installCheck for `${lib.getName package}` because firejail breaks it"
            false;
        }
        // (
          if (old.phases or []) != []
          then {
            phases = ensureElem old.phases "wrapFirejailPhase";
          }
          else {}
        )
    );

  wrapCommand = {
    package,
    makeWrapper,
    ...
  } @ args:
    package.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [makeWrapper];
      buildCommand = old.buildCommand + (script args);
    });
in
  {
    # package to wrap an executable in
    package,
    # paths of the executables to wrap relative to package root
    relativePath ? "/bin/" + (package.mainProgram or lib.getName package),
    # firejail profile to use (equivilent to `extraArgs = ["--profile=${profile}"]`)
    profile ? null,
    # extra arguments to pass to firejail
    extraArgs ? [],
    # path of the suid binary installed via package manager (on nixos that is '/run/wrappers/bin/firejail')
    firejailBinary ? "/run/wrappers/bin/firejail",
    pkgs ? null,
    lib ? pkgs.lib,
    makeWrapper ? pkgs.makeWrapper,
  }: let
    wrap =
      lib.throwIf ((package.buildCommandPath or "") != "")
      "wrapFirejail doesn't support derivations using `buildCommandPath`"
      (
        if (package.buildCommand or "") != ""
        then wrapCommand
        else wrapPhase
      );
  in
    wrap {
      inherit
        package
        lib
        makeWrapper
        relativePath
        firejailBinary
        ;

      firejailArgs = lib.escapeShellArgs (
        extraArgs ++ lib.optional (profile != null) "--profile=${profile}"
      );
    }
