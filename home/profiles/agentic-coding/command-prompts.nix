let
  review-scope = ''
    Scope: the whole codebase unless a diff, branch or path is given in "$ARGUMENTS". Never review an empty diff silently.
    List the directories/files you will cover before starting. Work through them one part at a time with at most 2 parallel agents.
    Apply the language guides in `~/.claude/rules/` for the languages in scope.
    Give each finding an identifier: severity letter + number (`C1` critical, `H1` high, `M3` medium, `L6` low).
  '';
  resolved-issue-format = ''
    Resolved issues files: grouped by resolution date under section headers; each entry keeps the original identifier, finding description and resolution details, e.g.
    `H1: [RESOLVED 2024-07-14 v1.2.3] SQL injection vulnerability in login endpoint`
  '';
  report-update-instructions = resolvedFile: ''
    Before writing: read `${resolvedFile}` (if it exists) and don't report findings again that were already resolved - unless they were reintroduced, then say so.
    Write the findings to the report file after each part so partial results survive an interruption.
    The report header contains the scope, the version/commit reviewed and an overall grade (A, A-, B+, B, B-, C+, C, C-, D+, D, F) reflecting all active findings.
    If the report already exists, update it (including new version information): move resolved issues out of the report into `${resolvedFile}` and recalculate the grade.
    ${resolved-issue-format}
  '';
  quality-review = ''
    Assess code against language-specific best practices and idioms. Identify quality issues and provide prioritized improvements.
    ${review-scope}
  '';
  security-review = ''
    Identify security vulnerabilities following language-specific practices. Rank by severity (Critical/High/Medium/Low) with fixes.
    ${review-scope}
  '';
in
{
  quality-review = {
    description = "Quality review of the whole codebase (or a given path/branch) against language best practices, prioritized findings";
    prompt = quality-review;
  };
  quality-review-report = {
    description = "Quality review written to REVIEW_REPORT.md with grade and identifiers";
    prompt = ''
      ${quality-review}
      Generate a markdown report summarizing the findings and recommendations and store it in REVIEW_REPORT.md.
      ${report-update-instructions "docs/RESOLVED_REVIEW_ISSUES.md"}
    '';
  };
  code-audit = {
    description = "Security audit of the whole codebase (or a given path/branch), findings ranked by severity";
    prompt = security-review;
  };
  code-audit-report = {
    description = "Security audit written to SECURITY_REPORT.md with grade and identifiers";
    prompt = ''
      ${security-review}
      Generate a markdown report summarizing the findings and recommendations and store it in SECURITY_REPORT.md.
      ${report-update-instructions "docs/RESOLVED_SECURITY_ISSUES.md"}
    '';
  };
  review-fix = {
    description = "Fix findings from REVIEW_REPORT.md / SECURITY_REPORT.md test-first, one commit per finding";
    prompt = ''
      Fix the findings given in "$ARGUMENTS" (identifiers like H1 M2, or a severity like "high"). If nothing is given, ask which findings to fix.
      Read them from REVIEW_REPORT.md or SECURITY_REPORT.md. Work in priority order; for each finding:
      1. Write a failing test that demonstrates it (skip only if the finding isn't testable, and say why)
      2. Implement the minimal fix
      3. Run the formatter, linters and tests from the language guide's checklist
      4. Move the finding to the resolved issues file (`docs/RESOLVED_REVIEW_ISSUES.md` or `docs/RESOLVED_SECURITY_ISSUES.md`), recalculate the report's grade, and commit: `fix(<id>): <summary>`
      ${resolved-issue-format}
      If a finding turns out to be wrong, correct the report and explain why instead of forcing a fix.
      Finish with a summary of the commits, test count before/after, and what was not verified.
    '';
  };
  fix-build = {
    description = "Reproduce a build failure, fix its root cause and verify the build passes";
    prompt = ''
      Fix the failing build. "$ARGUMENTS" may contain the error output, a CI job/pipeline or the build command; otherwise use the project's usual build (Makefile, CI config, language checklist).
      1. Reproduce the failure locally and quote the first relevant error - if it can't be reproduced (e.g. CI-only, sandbox blocks it), say so and work from the given output
      2. Identify the root cause; fix that, not the symptom (no disabling checks, `#[allow]`, `nolint`, skipped tests or pinned-back versions without asking)
      3. If the failure is a bug in code (not config/toolchain), add a test that covers it
      4. Re-run the build, linters and tests until they pass
      5. Commit: `fix: <summary>`
      Finish with the root cause in one or two sentences, the changes, and what was not verified (e.g. CI not re-run).
    '';
  };
  version-update = {
    description = "Bump this project's version in all manifests, version constants, Nix and Helm files";
    prompt = ''
      Use $ARGUMENTS as VERSION, or ask me for it. Note the current version as OLD_VERSION first.
      Update this project's own version in every manifest present (Cargo.toml, package.json, pyproject.toml, etc.) and in version constants in source (e.g. `version` in main.go, `__version__`). Refresh lockfiles to match (e.g. `cargo metadata`, `npm version VERSION --no-git-tag-version`).
      Nix: update `version` in workspace.nix if it exists in the root, otherwise in package.nix files next to manifests. Leave dependency hashes alone.
      Helm: patch-bump the chart `version`, set `appVersion` to VERSION, and update the image tag in values.yaml if it pins OLD_VERSION.
      Then grep for remaining occurrences of OLD_VERSION (skip lockfiles, vendor/, node_modules/, target/, CHANGELOG). Update the clear matches; ask me about ambiguous ones. Never change dependency versions. Don't commit or tag.
      Finish with a short summary of changed files and old to new values.
    '';
  };
  release-notes = {
    description = "Short markdown release notes for all changes since the latest tag";
    prompt = ''
      Analyze all code changes since the latest tag. Build and output release notes in a markdown code block. Keep the output short and concise, focus on the most important changes, exclude version bumps and unchanged features, and do not repeat yourself.
    '';
  };
}
