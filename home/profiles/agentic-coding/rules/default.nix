# The main rules (agent-rules.md) are deployed as managed CLAUDE.md by the NixOS profile
# `agentic-coding`; this module only deploys the path-scoped guides.
{ configDir }:
{ lib, ... }:

let
  # Deployed as path-scoped rules: Claude Code loads a guide only when it works on files matching
  # its `paths` globs, so the guides don't cost context in unrelated sessions.
  guides = [
    {
      name = "go.md";
      paths = [
        "**/*.go"
        "**/go.mod"
      ];
    }
    {
      name = "rust.md";
      paths = [
        "**/*.rs"
        "**/Cargo.toml"
      ];
    }
    {
      name = "js.md";
      paths = [
        "**/*.{js,mjs,cjs,jsx,ts,tsx,vue,svelte}"
        "**/package.json"
      ];
    }
    {
      name = "php.md";
      paths = [
        "**/*.php"
        "**/composer.json"
      ];
    }
    {
      name = "web.md";
      paths = [
        "**/*.{html,htm,css,scss,jsx,tsx,vue,svelte}"
        "**/*.{tmpl,gohtml,jinja,jinja2,j2,twig,hbs,ejs}"
        "**/*.blade.php"
        "**/templates/**"
        "**/static/**"
        "**/public/**"
      ];
    }
    {
      name = "containers.md";
      paths = [
        "**/Dockerfile*"
        "**/Containerfile*"
        "**/*.dockerfile"
        "**/.dockerignore"
        "**/docker-compose*.{yml,yaml}"
        "**/compose*.{yml,yaml}"
        "**/.gitlab-ci.yml"
        "**/.github/workflows/**"
        "**/Chart.yaml"
        "**/values*.yaml"
      ];
    }
  ];

  frontmatter = paths: ''
    ---
    paths:
    ${lib.concatMapStrings (path: "  - \"${path}\"\n") paths}---
  '';
in
{
  home.file = builtins.listToAttrs (
    map (guide: {
      name = "${configDir}/rules/${guide.name}";
      value.text = frontmatter guide.paths + "\n" + builtins.readFile (./guides + "/${guide.name}");
    }) guides
  );
}
