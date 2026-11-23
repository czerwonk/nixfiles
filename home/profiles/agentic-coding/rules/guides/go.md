# Go Guide

## Conventions
- MixedCaps for all identifiers, including constants: `MaxRetries` (exported), `defaultTimeout` (unexported) - no ALL_CAPS or underscores
- Keep initialisms in consistent case: `userID`, `apiURL`, `HTTPClient`
- Wrap errors with context: `fmt.Errorf("loading config: %w", err)`
- Never drop errors silently; if one is intentionally ignored, assign it to `_` with a comment why
- Document all exported identifiers (`// Name does ...`)
- Table-driven tests for multiple cases

## Checklist
1. `gofmt -w .`
2. `go vet ./...`
3. `golangci-lint run ./...` (incl. `errcheck`, `gosec` - CI runs it); fall back to `staticcheck ./...` and `revive ./...` if unavailable
4. `go test ./...`
