# Rust Guide

## Conventions
- `anyhow` for applications, `thiserror` for libraries
- No `unwrap()`/`expect()` in production code; if `expect()` is unavoidable, give a descriptive message
- Document why each dependency is needed; run `cargo audit` when updating dependencies
- **Tests return `Result<()>` and use `?` instead of `unwrap()`**, assertions carry a message:
  ```rust
  #[test]
  fn parses_config_file() -> Result<()> {
      let content = std::fs::read_to_string("test.txt")?;
      let parsed = serde_json::from_str::<MyStruct>(&content)?;
      assert_eq!(parsed.field, "expected_value", "field should be read from the file");
      Ok(())
  }
  ```

## Checklist
1. `cargo fmt` (CI checks with `cargo fmt --check`)
2. `cargo clippy --all-targets -- -D warnings` - fix warnings, don't `#[allow]` them without a reason
3. `cargo test`
4. Update CHANGELOG.md if the project has one
