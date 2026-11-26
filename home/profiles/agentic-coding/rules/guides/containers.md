# Containers

## Container Images
- Pin every image (base images in Dockerfiles, CI job images) by tag **and** digest: `image:1.2.3@sha256:...`
- Get the digest with `crane digest image:tag` - never guess or copy a digest from memory
- Prefer distroless or minimal non-root runtime images; use multi-stage builds

## Build Context
- Every Dockerfile/Containerfile needs a `.dockerignore`; create or update it when adding or changing one
- Exclude at least:
  - VCS and tooling: `.git`, `.gitignore`, `.github`, `.gitlab-ci.yml`, `.idea`, `.vscode`, `.claude`
  - Secrets and local config: `.env`, `.env.*` (keep templates like `.env.example` only if the build needs them), `*.pem`, `*.key`, `*.tfvars`
  - Build output and caches: `target/`, `dist/`, `build/`, `node_modules/`, `vendor/` (unless vendored deps are used in the build), `coverage/`, `*.log`
  - Container and deployment files not needed in the image: `Dockerfile*`, `.dockerignore`, `docker-compose*.yml`, Helm charts, `docs/`
- Never `COPY . .` without a `.dockerignore`; prefer copying only the paths the build needs

## Upstream Files
- Extract files shipped with charts or images (templates, default configs, rules) locally:
  - Helm charts: `helm pull <chart> --version <v> --untar`
  - Images: `podman create <image>` + `podman cp <id>:<path> .` + `podman rm <id>`
- Don't download them from GitHub or other web sources
