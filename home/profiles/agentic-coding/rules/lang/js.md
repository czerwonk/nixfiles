# JavaScript/TypeScript Style Guide

## Code Formatting
- **Always run `prettierd` after modifying any JS/TS files**
- Follow Prettier's opinionated formatting (prettierd enforces consistency)
- Configure prettier settings in `.prettierrc` or `package.json`

## Language Features
- Use `const` and `let`, never `var`
- Prefer arrow functions `=>` for callbacks and short functions
- Use template literals `` `${variable}` `` over string concatenation
- Use destructuring for objects and arrays when appropriate
- Prefer `async/await` over `.then()` for promises

## TypeScript Specific
- Use explicit type annotations for function parameters and return types
- Prefer interfaces over type aliases for object shapes
- Use union types `|` and intersection types `&` appropriately
- Enable strict mode in `tsconfig.json`
- Avoid `any` type - use `unknown` or proper types instead

## Naming Conventions
- Use camelCase for variables and functions
- Use PascalCase for classes, interfaces, and types
- Use SCREAMING_SNAKE_CASE for constants
- Use kebab-case for file names
- Prefix interfaces with `I` only if needed for disambiguation

## Code Structure
- Keep functions small and focused on a single responsibility
- Use descriptive variable names
- Prefer pure functions when possible
- Use modules (import/export) over global variables
- Group related imports together

## Error Handling
- Use try/catch blocks for error handling
- Create custom error classes when appropriate
- Handle promise rejections explicitly
- Use optional chaining `?.` and nullish coalescing `??` operators
- Validate input parameters in functions

## Dependencies
- Use `npm` or `yarn` for package management
- Keep dependencies up to date and minimal
- Use `package-lock.json` or `yarn.lock` for reproducible builds
- Prefer well-maintained packages with active communities

## Testing
- Write unit tests using Jest, Vitest, or similar frameworks
- Use descriptive test names that explain the behavior
- Test file naming: `*.test.js` or `*.spec.js`
- Use `describe` and `it` blocks for organized test structure
- Mock external dependencies in tests

## Comments and Documentation
- Use `//` for single-line comments
- Use `/* */` for multi-line comments
- Use JSDoc `/** */` for function and class documentation
- Document complex business logic and algorithms
- Avoid obvious comments, focus on why rather than what

## Linting and Quality
- Use ESLint for code linting
- Use TypeScript compiler checks for TS files
- Address linting warnings and errors
- Use `@typescript-eslint` rules for TypeScript projects

## Post-Modification Checklist
1. Run `prettierd --write .` to format code
2. Run `eslint` to check for linting issues
3. Run `tsc --noEmit` for TypeScript type checking (TS projects)
4. Run tests to ensure functionality works
5. Commit changes following git discipline rules
