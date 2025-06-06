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

## Workflow

1. Pick task
2. **Write tests first** (for features/fixes)
3. Complete task
4. Update todo.md
5. **COMMIT CHANGES** (required - no exceptions)