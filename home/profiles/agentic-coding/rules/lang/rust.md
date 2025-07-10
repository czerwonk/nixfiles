# Rust Style Guide

## Code Formatting
- **Always run `cargo fmt` after modifying any Rust files**
- Follow standard Rust formatting conventions (rustfmt enforces most of these)

## Naming Conventions
- Use snake_case for variables, functions, and modules
- Use SCREAMING_SNAKE_CASE for constants and statics
- Use PascalCase for types, traits, and enums
- Use snake_case for crate names (prefer single word when possible)

## Code Structure
- Keep functions small and focused on a single responsibility
- Use descriptive variable names
- Prefer explicit error handling with `Result<T, E>`
- Use `clippy` suggestions to improve code quality
- Avoid `unwrap()` and `expect()` in production code - handle errors properly

## Error Handling
- Use `Result<T, E>` for recoverable errors
- Use `panic!` only for unrecoverable errors
- Use `?` operator for error propagation
- Create custom error types for complex applications
- Use `anyhow` or `thiserror` for error handling in applications

## Memory Management
- Prefer borrowing over cloning when possible
- Use `Rc<T>` and `Arc<T>` judiciously for shared ownership
- Understand lifetime annotations and use them when necessary
- Avoid `unsafe` code unless absolutely necessary

## Dependencies
- Use `Cargo.toml` for dependency management
- Keep dependencies minimal and well-maintained
- Prefer crates.io packages with good maintenance records
- Use `cargo audit` to check for security vulnerabilities

## Testing
- Write unit tests in the same file using `#[cfg(test)]`
- Use integration tests in `tests/` directory
- Test function naming: descriptive names explaining what is tested
- Use `cargo test` to run all tests

## Comments and Documentation
- Use `//` for single-line comments
- Use `///` for documentation comments on public items
- Use `//!` for module-level documentation
- Document all public functions, structs, enums, and traits
- Focus on why rather than what in comments

## Linting and Quality
- Use `cargo clippy` for additional linting
- Address clippy warnings and errors
- Use `cargo check` for fast compilation checks
- Enable additional lints in `Cargo.toml` or `lib.rs`

## Post-Modification Checklist
1. Run `cargo fmt` to format code
2. Run `cargo clippy` to check for linting issues
3. Run `cargo test` to ensure tests pass
4. Run `cargo check` for compilation verification
5. Commit changes following git discipline rules
