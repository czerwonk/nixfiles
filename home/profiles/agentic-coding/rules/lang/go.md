# Go Style Guide

## Code Formatting
- **Always run `gofmt` after modifying any Go files**
- Follow standard Go formatting conventions (gofmt enforces most of these)

## Naming Conventions
- Use camelCase for variables and functions
- Use PascalCase for exported functions and types
- Use ALL_CAPS for constants
- Package names should be lowercase, single words when possible

## Code Structure
- Keep functions small and focused on a single responsibility
- Use descriptive variable names, even if they're longer
- Prefer explicit error handling over panics
- Use `go vet` to catch common issues

## Error Handling
- Always handle errors explicitly
- Return errors as the last return value
- Use `fmt.Errorf()` for wrapping errors with context
- Avoid using `panic()` except for truly unrecoverable situations

## Dependencies
- Use Go modules for dependency management
- Keep dependencies minimal and well-maintained
- Prefer standard library over external packages when possible

## Testing
- Write tests for all public functions
- Use table-driven tests for multiple test cases
- File naming: `*_test.go`
- Test function naming: `TestFunctionName`

## Comments
- Use `//` for single-line comments
- Document all exported functions, types, and constants
- Follow the format: `// FunctionName does something...`
- Avoid obvious comments, focus on why rather than what

## Post-Modification Checklist
1. Run `gofmt -w .` to format code
2. Run `go vet` to check for issues
3. Run `go test` to ensure tests pass
4. Commit changes following git discipline rules
