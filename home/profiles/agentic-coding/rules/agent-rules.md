# General Rules
## 1. Conversation Mode
- **Discussion mode**: when I start with "Let us discuss" or similar, or run `/opsx:explore`, only discuss approaches, pros/cons and architecture - don't change files (OpenSpec artifacts only if I ask to capture the result)
- **Proposal mode**: `/opsx:propose` or "write a proposal/spec" creates the OpenSpec change artifacts only - no code changes
- **Implementation mode**: implement only when I explicitly ask for it ("Can you implement the login feature?") or run `/opsx:apply`
- If the mode is unclear, ask: "Should I discuss the approach, write an OpenSpec proposal or implement the solution?"
## 2. General Behavior
- Clarify ambiguities before proceeding
- Break complex topics into digestible parts
- Give items in generated lists (TODOs, suggestions, findings) identifiers like `H1`, `M3`, `L6` (high/medium/low priority + number) so we can refer to them
- If I correct a design, don't claim the earlier version was agreed upon unless I said so explicitly - re-read what was actually agreed (e.g. "shared logic" is not "shared state")
# Development Rules
## 1. Spec-Driven Work (OpenSpec)
- Projects with an `openspec/` directory use OpenSpec: `openspec/specs/` is the current source of truth, planned work lives in `openspec/changes/<change>/` (`proposal.md` why/what, `design.md` how + decisions, `specs/` delta specs, `tasks.md` checklist)
- Use the `/opsx:*` commands and the `openspec` CLI (`openspec list`, `openspec status --change <name>`) - don't hand-roll the structure
- Anything that adds or changes behavior gets a change; bug fixes and refactorings that keep specified behavior don't need one
- Break work into small, completable units: each `tasks.md` item is one commit-sized step that includes its tests (written first) and leaves the build green; the last task group is "Wrap-up" (README for user-facing changes, full formatter/linter/test run)
- In `design.md` for changes covered by section 4 (Design Before Code), add a "Data and State" section with that checklist
- Record decisions and rationale in `design.md`, not only in chat
- If implementation reveals a design issue or deviates from the spec, stop, update `design.md`/delta specs and tell me before continuing
- Change `openspec/specs/` only via `/opsx:sync` or `/opsx:archive`, never directly; never edit `openspec/changes/archive/`; archive only when I ask
- Projects without `openspec/`: for non-trivial features, suggest `openspec init --tools claude` once - don't track tasks in ad-hoc files like `docs/todo.md`
## 2. Scope Control
- Only implement what was requested - with OpenSpec, the tasks of the selected change
- Don't add follow-up ideas or technical debt to the current change: list them (with identifiers) and offer a separate change
## 3. Reuse Before Building
- Before writing infrastructure code (telemetry, logging, DB pools, CI jobs, deployment config, helper scripts), look for an existing shared library, template, script or Makefile target in the repo and its dependencies, and use it
- If I say "use the script/library/template", find the existing one - don't write a new one
- Never invent image, registry, chart or deployment names - read them from the Makefile, chart, CI config or existing deployment, or ask
## 4. Design Before Code
For changes touching the data model, persistence, caching, nullability or concurrency, first give a short plan and wait for my OK. With OpenSpec the plan goes into the change's `design.md` and approving the proposal is the OK; design questions that only come up during apply need a new OK:
- Stored values and invariants (e.g. NULL vs. a literal default, allowed value sets)
- Other writers and callers of the affected data/code
- What is shared and what stays separate (logic vs. state/cache)
- Which existing code/libraries are reused
## 5. Workflow
For every change, including one-off changes - with OpenSpec per `tasks.md` item:
1. Write a failing test first (features and fixes); skip this for changes without testable behavior (docs, comments, config tweaks, rule files)
2. Implement
3. Run the formatter, linters and tests from the guide's checklist
4. Update the README for user-facing changes (features, flags, configuration); with OpenSpec tick the task (`- [ ]` → `- [x]`)
5. Defined tasks only (see section 6): commit code, tests and the ticked task together on the change branch
6. Report what was not verified (see section 11)
## 6. Git
- **Never run `git push`** - pushing is always done by me
- Defined tasks - an OpenSpec change (`/opsx:apply`) or work I explicitly ask to be done on a branch:
  - Work on a branch per change (`wt switch -c <change-name>`), never commit directly to the default branch
  - Commit per task (with OpenSpec: each `tasks.md` item) on that branch as checkpoints; OpenSpec artifacts get their own checkpoint commits (`docs: propose <change>`, `docs: update <change> design`)
  - When the change is complete (wrap-up green), show the branch commits and the proposed squash commit message, wait for my OK, then run `wt merge`
  - The squash commit contains everything - code, tests, ticked `tasks.md` and OpenSpec artifacts - so reverting it undoes the whole change
- One-off changes outside a defined task (small fixes, config tweaks, rule updates): don't commit - leave the changes in the working tree and summarize them for review
- Format: `type: description` (feat/fix/docs/refactor/test/chore/ci), one logical change per commit
- Never amend, squash or rewrite commits you didn't create in this session without asking
## 7. CI/CD and Deployment
- Check `.gitignore` for patterns like `*.yml` that would hide `.gitlab-ci.yml` or other CI files
- Before committing CI/CD or deployment changes, state whether pushing the branch triggers a deployment or whether deploys are tag-based
## 8. Code Quality
- Keep it simple, avoid premature optimization, prefer readable over clever code
- Tests with more than one assertion give context on failure (e.g. assertion messages / description strings)
- Comments explain why, not what: non-obvious logic, business rules, workarounds (with TODO/FIXME), API docs for public interfaces. No comments that restate the code - prefer descriptive names and small functions instead
- Trim trailing whitespace, no trailing blank lines at end of file, consistent indentation
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
## 10. Sandbox and Tools
- You run in a sandbox (bubblewrap in the terminal, firejail in Zed). Writable: the project, `/tmp` (private to the sandbox - I can't see files there), `~/.claude` and tool caches (`~/.cache`, Go/Cargo stores). Everything else is read-only or hidden by design
- In the repository `.git/config` and `.git/hooks` are read-only: commits work, but no `git config`, `git remote add/set-url` or hooks - tell me if one is needed
- **Don't try to write outside the sandbox context** - not to check whether it works, not via another path, tool or `sudo`. It fails every time and only costs time and tokens. If a task needs it, say so and stop
- No remote access: `ssh`, `scp`, `sftp`, `rsync` are denied - if a task needs a remote host, tell me the command and I'll run it myself
- Missing tools: use `nix shell nixpkgs#<package> -c <command>` (or `nix run`); never install globally (`nix profile install`, `cargo install`, `go install`, `npm -g`, `pip install --user`, `curl | sh`)
- Containers: **there is no Docker, only Podman** - `podman` talks to the host's rootless podman service (remote mode, `CONTAINER_HOST`), so images, containers and volumes live on the host; use `podman` (`podman build`, `podman run`, `podman compose`), `docker` is just an alias on the workstation; Dockerfiles work as they are
- Every podman call is reviewed by me before it runs, so:
  - Bind mounts (`-v`, `--volume`, `--mount`) only for paths inside the project; podman runs on the host (remote mode), so paths resolve there and the sandbox's private `/tmp` is not reachable; **never mount anything outside the project** - no `$HOME` or paths in it outside the project, no `/`, `/tmp`, `/etc`, `/run`, `/nix`, `/var`, no sockets (podman/docker socket, ssh/gpg agent)
  - No `--privileged`, `--cap-add`, `--device`, `--security-opt`, `--pid=host`, `--userns=host`, `--ipc=host`
## 11. Verification Honesty
- At the end of each task, list what was not verified, e.g.: not checked in a browser, not run against a real database, no CI pipeline run, image not built, changes left uncommitted (one-off changes) or branch not yet merged
- If the sandbox blocks git, a linter, podman or a network fetch, say so immediately and name the blocked path/command - don't retry or work around it. If the podman socket is missing, the host's `podman.socket` isn't running: ask me to start it
## 12. Dependencies
- Avoid new external dependencies unless necessary; state the reason when adding one
- New projects only, before the first commit: use the latest versions and the current patch release of the toolchain (Go, Rust, Node, ...) and update indirect dependencies too (`go get -u ./... && go mod tidy`, `cargo update`, `npm update`)
- In existing projects, update dependencies only when asked
