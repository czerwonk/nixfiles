{
  configDir,
  mainConfigFile,
}:
{ config, lib, ... }:

let
  languageFiles = [
    {
      language = "Go";
      name = "go.md";
      path = ./lang/go.md;
    }
    {
      language = "Rust";
      name = "rust.md";
      path = ./lang/rust.md;
    }
    {
      language = "TypeScript/JavaScript";
      name = "js.md";
      path = ./lang/js.md;
    }
    {
      language = "PHP";
      name = "php.md";
      path = ./lang/php.md;
    }
    {
      language = "HTML";
      name = "html.md";
      path = ./lang/html.md;
    }
    {
      language = "Containers, CI/CD and dependency updates";
      name = "containers.md";
      path = ./lang/containers.md;
    }
  ];

  languageRulesSection = ''
    ## Language-Specific Rules
    ${lib.concatMapStringsSep "\n" (
      lang: "- **${lang.language}**: See `~/${configDir}/lang/${lang.name}`"
    ) languageFiles}

    When working in a specific language or area, read the relevant guide first.
  '';
in
{
  home.file =
    {
      "${configDir}/${mainConfigFile}".text = ''
        ${builtins.readFile ./agent-rules.md}

        ${languageRulesSection}
      '';
    }
    // builtins.listToAttrs (
      map (lang: {
        name = "${configDir}/lang/${builtins.baseNameOf lang.name}";
        value.text = builtins.readFile lang.path;
      }) languageFiles
    );
}
