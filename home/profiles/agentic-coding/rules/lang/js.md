# JavaScript/TypeScript Guide

Frontend code also follows the web UI guide (`web.md`).

## Conventions
- Follow current best practices and the project's existing ESLint/TypeScript configuration
- TypeScript: strict mode, no `any` (use `unknown` or proper types)

## Checklist
1. `prettierd --write .`
2. `eslint`
3. `tsc --noEmit` (TypeScript projects)
4. Run the tests
5. UI changes: check them visually (screenshots at ~390px and ~1440px width) - if that's not possible, report the change as not visually verified
