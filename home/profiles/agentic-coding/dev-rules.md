# Development Rules

## 1. Task Management

- Break into small, completable units
- Track in `docs/todo.md`:
  - [ ] Current/upcoming tasks (with priority: high/medium/low)
  - [x] Completed tasks
  - Development decisions + rationale
  - Recurring issues + solutions
  - Technical debt
  - Code audit reminders

## 2. Git Discipline

- **ALWAYS commit after each task that modifies any file**
- No exceptions - even small fixes require commits
- Format: `type: description` (feat/fix/docs/refactor/test/chore)

## 3. Scope Control

- Only implement explicit requests
- Clarify ambiguities
- Log additional ideas as separate tasks

## 4. Code Quality

- Keep it simple (KISS principle)
- Avoid premature optimization
- Prefer readable over clever code
- **Create tests BEFORE implementing features** (TDD approach)
- Ask "Should I write tests for this?" if unclear

## 5. Code Commenting Guidelines

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

## Dependency Guidelines

- Avoid introducing new external dependencies unless absolutely necessary.
- If a new dependency is required, please state the reason.

## Workflow

1. Pick task
2. **Write tests first** (for features/fixes)
3. Complete task
4. Update todo.md
5. **COMMIT CHANGES** (required - no exceptions)
