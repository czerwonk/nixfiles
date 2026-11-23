# General Rules
## 1. Conversation Mode
- **DISCUSSION MODE**: When conversation starts with "Let us discuss" or similar phrases - ONLY discuss solutions, do NOT implement
- **IMPLEMENTATION MODE**: Only implement when explicitly asked to do so
- **When in doubt**: Ask "Should I discuss the approach or implement the solution?"
### Examples:
- ✅ "Let's discuss how to implement user authentication" → Discuss approaches, pros/cons, architecture
- ✅ "Can you implement the login feature?" → Go ahead and implement
- ❌ "Let's discuss the login feature" → Don't implement, just discuss
## 2. General Behavior
- Clarify ambiguities before proceeding
- Break complex topics into digestible parts
- When you generate lists (for example TODOs or suggestions) use identifiers to refer to in the conversation
- If I correct a design, don't claim the earlier version was agreed upon unless I said so explicitly - re-read what was actually agreed (e.g. "shared logic" is not "shared state")
# Development Rules
## 1. Task Management
- Break into small, completable units
- Track tasks in `docs/todo.md` only if the project uses this workflow:
  - If the file exists, use it
  - If it doesn't exist, check project memory for a decision; if there is none, ask once whether this project should use `docs/todo.md` and store the answer in project memory
- `docs/todo.md` contains:
  - [ ] Current/upcoming tasks (with priority: high/medium/low)
  - [x] Completed tasks
  - Development decisions + rationale
  - Recurring issues + solutions
  - Technical debt
  - Code audit reminders
## 2. Reuse Before Building
- Before writing infrastructure code (telemetry, logging, DB pools, CI jobs, deployment config, helper scripts), look for an existing shared library, template, script or Makefile target in the repo and its dependencies, and use it
- If I say "use the script/library/template", find the existing one - don't write a new one
- Never invent image, registry, chart or deployment names - read them from the Makefile, chart, CI config or existing deployment, or ask
## 3. Design Before Code
For changes touching the data model, persistence, caching, nullability or concurrency, first give a short plan and wait for my OK:
- Stored values and invariants (e.g. NULL vs. a literal default, allowed value sets)
- Other writers and callers of the affected data/code
- What is shared and what stays separate (logic vs. state/cache)
- Which existing code/libraries are reused
## 4. Git Discipline
- **ALWAYS commit after each task that modifies any file**
- No exceptions - even small fixes require commits
- Format: `type: description` (feat/fix/docs/refactor/test/chore/ci)
- One logical change per commit
- Never amend, squash or rewrite commits you didn't create in this session without asking
## 5. CI/CD and Deployment
- Check `.gitignore` for patterns like `*.yml` that would hide `.gitlab-ci.yml` or other CI files
- Before committing CI/CD or deployment changes, state whether pushing the branch triggers a deployment or whether deploys are tag-based
- Never push to a branch that deploys without asking
## 6. Scope Control
- Only implement explicit requests
- Log additional ideas as separate tasks
## 7. Code Quality
- Keep it simple (KISS principle)
- Avoid premature optimization
- Prefer readable over clever code
- Keep the README up to date with user-facing changes (features, flags, configuration)
- **Create tests BEFORE implementing features and fixes** (TDD: failing test first, then the fix)
- Whenever writing tests with more than one assertion make sure to give the dev context why the test failed. For example by using description strings if available.
## 8. Code Commenting Guidelines
When writing code, follow these commenting principles:
1. **Avoid obvious comments** - Do not comment code that is self-explanatory
   - Bad: `// Increment counter` above `counter++`
   - Bad: `// Return the result` above `return result`
2. **Comment only when necessary:**
   - Complex algorithms or non-obvious logic
   - Business rules or domain-specific requirements
   - Workarounds or temporary fixes (with TODO/FIXME)
   - Why something is done a certain way (not what)
   - API documentation (JSDoc, RustDoc, etc.) for public interfaces
3. **Prefer self-documenting code:**
   - Use descriptive variable and function names
   - Extract complex conditions into well-named variables
   - Break down complex functions into smaller, well-named functions
4. **Examples of valuable comments:**
   - `// Using binary search here for O(log n) performance`
   - `// Retry 3 times to handle transient network failures`
   - `// This seemingly redundant check prevents a race condition when...`
## 9. Security
- **Never read production credentials unless I explicitly ask for it in the current request** - not to debug, not to "check the config", not via a detour (`cat`, `grep`, `env`, `printenv`, a script, a subagent). This covers:
  - Env files: `.env`, `.env.local`, `.env.prod`, `.env.production`, `.env.staging` and similar (templates like `.env.example`, `.env.sample`, `.env.dist` are fine)
  - Config files containing credentials: `config.yml`/`config.yaml`/`config.json` of deployed environments, `secrets.*`, `credentials.*`, `appsettings.Production.json`, `application-prod.*`, `app/etc/env.php`, `wp-config.php`, `config/master.key`, `*.tfvars`, `*.tfstate`, Helm values of production releases
  - Keys and certificates: `*.pem`, `*.key`, `*.p12`, `*.pfx`, `*.jks`, `id_rsa*`, `id_ed25519*`, `*.kdbx`, age/sops keys, ansible vault password files
  - Credential stores in `$HOME`: `~/.ssh`, `~/.gnupg`, `~/.aws`, `~/.kube`, `~/.docker/config.json`, `~/.netrc`, `~/.git-credentials`, `~/.pgpass`, `~/.my.cnf`, `~/.npmrc`, `~/.cargo/credentials.toml`, `~/.config/gh`, `~/.config/gcloud`
  - Secret-revealing commands: `kubectl get secret -o yaml/json`, `sops -d`, `ansible-vault view/decrypt`, `vault read`, `terraform output` of sensitive values, dumping the environment
- If a task seems to need such a file, say so and ask - work from templates, schemas or the code that reads the config instead
- If you come across credentials anyway, don't repeat, log or store them (including memory) and tell me
- Never build SQL queries or shell commands from input - use query parameters and argument arrays
- Never log or commit secrets/tokens; compare tokens and other secrets in constant time
- In public repositories (e.g. github.com remotes, unless known to be private) never put internal hostnames, IPs, infrastructure details or customer data into code, docs, tests or commit messages
## 10. Dependencies
- Avoid introducing new external dependencies unless absolutely necessary
- If a new dependency is required, please state the reason
- Use the latest versions and the current patch release of the toolchain (Go, Rust, Node, ...)
- Update indirect dependencies too, e.g.:
  - Go: `go get -u ./... && go mod tidy`
  - Rust: `cargo update`
  - Node: `npm update`
- Do this before the first commit of a new project
## 11. Code Formatting
- **Always trim trailing whitespace** from all lines
- Remove unnecessary blank lines at end of files
- Maintain consistent indentation
## 12. Workflow
1. Pick task
2. **Write tests first** (for features/fixes)
3. Complete task
4. Run the formatter, linters and tests from the language guide's checklist
5. Update `docs/todo.md` (if the project uses it)
6. **COMMIT CHANGES** (required - no exceptions)
7. Report what was **not** verified (see below)
## 13. Verification Honesty
- At the end of each task, list what was NOT verified, e.g.: not checked in a browser, not run against a real database, no CI pipeline run, not pushed, image not built
- If the sandbox blocks git, a linter, podman or a network fetch, say so immediately and name the blocked path/command - don't retry or work around it
# Report Rules
## Scope
- Audits and reviews cover the **whole codebase** unless a diff, branch or path is named explicitly - never silently review an empty diff
- State the scope (directories/files) before starting
- Write findings to the report file after each part, so partial results survive an interruption
- Use at most 2 parallel agents
## File Naming Standards
- **Security audit reports**: `SECURITY_REPORT.md`
- **Code Review (Code Quality) reports**: `REVIEW_REPORT.md`
- **Resolved issues files**:
  - Security: `docs/RESOLVED_SECURITY_ISSUES.md`
  - Review: `docs/RESOLVED_REVIEW_ISSUES.md`
## Report Creation Process
1. **Before creating a new report**: Always read the corresponding resolved issues file to prevent reintroducing findings that have already been addressed
2. **Cross-reference findings**: Ensure new findings are not duplicates of previously resolved issues
## Identifiers
For each item (e.g. recommendation) create an identifier to be used for further discussion:
Examples of good identifiers:
   - `H1`: top priority finding
   - `M3`: third medium priority finding
   - `L6`: sixth low priority finding
## Overall Grade Calculation
- **Security and code review reports MUST include an overall grade** (A, A-, B+, B, B-, C+, C, C-, D+, D, F)
- Grade should reflect the cumulative security risk or code quality based on all active findings
## Report Updates
On each update (adding findings, marking issues resolved, etc.):
1. Update the relevant finding/section
2. **Move resolved issues to the resolved issues file** - do NOT keep them in the main report
3. **Recalculate the overall grade** (excluding resolved issues) and update it in the report header/summary
## Resolved Issues Management
- Add the date and version when the issue was resolved
- Include the original identifier for tracking
- Example: `H1: [RESOLVED 2024-07-14 v1.2.3] SQL injection vulnerability in login endpoint`
- Keep the original finding description and resolution details
- Group by resolution date under clear section headers
