# Containers, CI/CD and Dependencies

## Container Images
- Pin every image (base images in Dockerfiles, CI job images) by tag **and** digest: `image:1.2.3@sha256:...`
- Get the digest with `crane digest image:tag` - never guess or copy a digest from memory
- Prefer distroless or minimal non-root runtime images; use multi-stage builds
- Use the image names from the existing Makefile/CI/chart - never invent them

## Upstream Files
- Extract files shipped with charts or images (templates, default configs, rules) locally:
  - Helm charts: `helm pull <chart> --version <v> --untar`
  - Images: `podman create <image>` + `podman cp <id>:<path> .` + `podman rm <id>`
- Don't download them from GitHub or other web sources

## Dependency Updates
- Use the latest versions and the current patch release of the toolchain (Go, Rust, Node, ...)
- Update indirect dependencies too:
  - Go: `go get -u ./... && go mod tidy`
  - Rust: `cargo update`
  - Node: `npm update`
- Do this before the first commit of a new project

## CI/CD
- Check `.gitignore` for patterns like `*.yml` that would hide `.gitlab-ci.yml` or other CI files
- Before committing, state whether pushing to the branch triggers a deployment or whether deploys are tag-based
- Never push to a branch that deploys without asking
