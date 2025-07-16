# Rust Style Guide

## Code Formatting
- **Always run `cargo fmt` after modifying any Rust files**
- Follow standard Rust formatting conventions (rustfmt enforces most of these)
- Keep line length under 100 characters (rustfmt default)

## Naming Conventions
- Use `snake_case` for variables, functions, modules, and macro names
- Use `SCREAMING_SNAKE_CASE` for constants and statics
- Use `PascalCase` for types, traits, enums, and type parameters
- Use `snake_case` for crate names (prefer single word when possible)
- Use descriptive names that convey purpose and context
- Avoid abbreviations unless they're widely understood (e.g., `std`, `cfg`)

## Code Structure and Organization
- Keep functions small and focused on a single responsibility
- Use descriptive variable names that explain intent
- Organize code into logical modules with clear boundaries
- Place related functionality together
- Use `mod.rs` or single-file modules based on complexity
- Prefer composition over inheritance patterns
- Use builder patterns for complex struct initialization

## Error Handling
- **Always prefer `Result<T, E>` over `panic!` for recoverable errors**
- Use `panic!` only for unrecoverable errors and programming bugs
- Use the `?` operator for clean error propagation
- Create custom error types for domain-specific errors
- Use `anyhow` for applications, `thiserror` for libraries
- Avoid `unwrap()` and `expect()` in production code
- When using `expect()`, provide descriptive error messages
- Consider using `Option<T>` for values that may be absent

## Memory Management and Ownership
- Prefer borrowing (`&T`) over cloning when possible
- Use `Rc<T>` for single-threaded shared ownership
- Use `Arc<T>` for multi-threaded shared ownership
- Use `RefCell<T>` and `Mutex<T>` for interior mutability
- Understand lifetime annotations and use them appropriately
- Minimize use of `Clone` trait unless semantically correct
- Avoid `unsafe` code unless absolutely necessary and well-documented
- Use `Box<T>` for heap allocation when stack size is a concern

## Performance and Efficiency
- Use iterators instead of for loops when appropriate
- Prefer `Iterator::collect()` over manual collection building
- Use `Vec::with_capacity()` when final size is known
- Consider using `Cow<T>` for conditional ownership
- Profile before optimizing - don't guess at performance bottlenecks
- Use `#[inline]` judiciously for hot paths
- Prefer zero-cost abstractions

## Dependencies and Crate Management
- Use `Cargo.toml` for all dependency management
- Keep dependencies minimal and well-maintained
- Prefer crates.io packages with good maintenance records
- Use semantic versioning constraints appropriately
- Regularly run `cargo audit` to check for security vulnerabilities
- Use `cargo outdated` to check for dependency updates
- Consider using `cargo deny` for additional dependency policies
- Document why each dependency is needed

## Testing Strategy
- Write unit tests in the same file using `#[cfg(test)]`
- Use integration tests in `tests/` directory for end-to-end testing
- Use descriptive test function names explaining what is tested
- Follow the Arrange-Act-Assert pattern in tests
- **Prefer `Result<()>` return type and `?` operator over `unwrap()` in tests**
- This provides better error messages when tests fail:
  ```rust
  #[test]
  fn test_file_operations() -> Result<()> {
      let content = std::fs::read_to_string("test.txt")?;
      let parsed = serde_json::from_str::<MyStruct>(&content)?;
      assert_eq!(parsed.field, "expected_value");
      Ok(())
  }
  ```
- Use `cargo test` to run all tests
- Use `cargo test -- --nocapture` to see print statements in tests
- Consider property-based testing with `proptest` for complex logic
- Use `cargo tarpaulin` or similar for code coverage

## Documentation and Comments
- Use `//` for single-line comments
- Use `///` for documentation comments on public items
- Use `//!` for module-level documentation
- Document all public functions, structs, enums, and traits
- Include examples in documentation comments
- Focus on *why* rather than *what* in comments
- Use `cargo doc --open` to generate and view documentation
- Write comprehensive README.md files for crates

## Linting and Code Quality
- Use `cargo clippy` for additional linting beyond the compiler
- Address all clippy warnings and errors
- Use `cargo check` for fast compilation checks during development
- Enable additional lints in `Cargo.toml` or `lib.rs`:
  ```toml
  [lints.rust]
  unsafe_code = "forbid"
  
  [lints.clippy]
  enum_glob_use = "deny"
  pedantic = "warn"
  nursery = "warn"
  ```
- Use `rustc` warning flags for stricter compilation
- Consider using `cargo machete` to find unused dependencies

## Cargo Features and Configuration
- Use feature flags to make functionality optional
- Keep default features minimal
- Document feature flags in README and lib.rs
- Use `no_std` when appropriate for embedded/constrained environments
- Configure workspace properly for multi-crate projects

## Concurrency and Async
- Use `async`/`await` for asynchronous code
- Prefer `tokio` or `async-std` for async runtimes
- Use `Arc<Mutex<T>>` for shared mutable state across threads
- Consider using channels for communication between threads
- Use `rayon` for data parallelism
- Be mindful of `Send` and `Sync` traits when working with concurrency

## Security Best Practices
- Validate all external inputs
- Use type system to encode invariants
- Avoid string-based APIs when possible
- Use `secrecy` crate for sensitive data
- Regularly update dependencies for security patches
- Consider using `cargo-audit` in CI/CD pipelines

## Development Workflow
### Pre-commit Checklist
1. Run `cargo fmt` to format code
2. Run `cargo clippy` to check for linting issues
3. Run `cargo test` to ensure all tests pass
4. Run `cargo check` for compilation verification
5. Run `cargo doc` to ensure documentation compiles
6. Update CHANGELOG.md if applicable

### Continuous Integration
- Set up automated testing for multiple Rust versions
- Include clippy and rustfmt checks in CI
- Run security audits automatically
- Consider using `cargo-deny` for dependency validation
- Test on multiple platforms if applicable

## Common Patterns and Idioms
- Use `match` for pattern matching instead of multiple `if let`
- Prefer `if let` and `while let` for single-pattern matches
- Use `Default` trait for sensible defaults
- Implement `Display` and `Debug` traits appropriately
- Use `From` and `Into` traits for type conversions
- Prefer `Iterator` methods over manual loops
- Use `Option::map()` and `Result::map()` for transformations

## Performance Considerations
- Use `&str` instead of `String` for string slices
- Prefer `Vec<T>` over `LinkedList<T>` in most cases
- Use `HashMap` with a good hasher for hash tables
- Consider using `SmallVec` for small collections
- Profile with `cargo flamegraph` or similar tools
- Use `#[cold]` attribute for error paths

This guide should be regularly updated as the Rust ecosystem evolves and new best practices emerge.
