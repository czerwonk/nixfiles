# General Rules
## 1. Conversation Mode
- **DISCUSSION MODE**: When conversation starts with "Let us discuss" or similar phrases - ONLY discuss solutions, do NOT implement
- **IMPLEMENTATION MODE**: Only implement when explicitly asked to do so
- **When in doubt**: Always ask before implementing anything
### Examples:
- ✅ "Let's discuss how to implement user authentication" → Discuss approaches, pros/cons, architecture
- ✅ "Can you implement the login feature?" → Go ahead and implement  
- ❌ "Let's discuss the login feature" → Don't implement, just discuss
- ❓ Unclear request → Ask: "Should I discuss the approach or implement the solution?"
## 2. General Behavior
- If unclear about mode, ask: "Should I discuss the approach or implement the solution?"
- Clarify ambiguities before proceeding
- Break complex topics into digestible parts
- When you generate lists (for example TODOs or suggestions) use identifier to refere to in the conversation
# Important local paths
- **Screenshots**: ~/Pictures/Screenshots
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
- Whenever writing tests with more than one assertion make sure to give the dev context why the test failed. For example by using description strings if available.
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
## 6. Dependency Guidelines
- Avoid introducing new external dependencies unless absolutely necessary
- If a new dependency is required, please state the reason
## 7. Code Formatting
- **Always trim trailing whitespace** from all lines
- Remove unnecessary blank lines at end of files
- Maintain consistent indentation
## 8. Workflow
1. Pick task
2. **Write tests first** (for features/fixes)
3. Complete task
4. Update todo.md
5. **COMMIT CHANGES** (required - no exceptions)
# Report Rules
## File Naming Standards
- **Security audit reports**: Always named `SECURITY_REPORT.md`
- **Code Review (Code Quality) reports**: Always named `REVIEW_REPORT.md`
- **Resolved issues files**:
  - Security: `docs/SECURITY_REPORT_RESOLVED.md`
  - Review: `docs/REVIEW_REPORT_RESOLVED.md`
## Report Creation Process
1. **Before creating a new report**: Always read the corresponding resolved issues file to prevent reintroducing findings that have already been addressed
2. **Check resolved issues**:
   - For security reports: Review `docs/RESOLVED_SECURITY_ISSUES.md`
   - For review reports: Review `docs/RESOLVED_REVIEW_ISSUES.md`
3. **Cross-reference findings**: Ensure new findings are not duplicates of previously resolved issues
## Identifiers
For each item (e.g. recommendation) create an identifier to be used for further discussion:
Examples of good identifiers:
   - `H1`: top priority finding
   - `M3`: third medium priority finding
   - `L6`: sixth low priority finding
## Overall Grade Calculation
- **Security and code review reports MUST include an overall grade** (A, A-, B+, B, B-, C+, C, C-, D+, D, F)
- Grade should reflect the cumulative security risk or code quality based on all findings
- **ALWAYS recalculate and update the grade** when:
  - Adding new findings
  - Moving issues to resolved files
  - Modifying existing findings
  - Making any changes that affect the overall assessment
## Resolved Issues Management
- **Do NOT keep resolved issues in the main report**
- **Move resolved issues to dedicated files**:
  - Security issues → `docs/RESOLVED_SECURITY_ISSUES.md`
  - Review issues → `docs/RESOLVED_REVIEW_ISSUES.md`
- **When moving resolved issues**:
  - Add the date and version when the issue was resolved
  - Include the original identifier for tracking
  - Example: `H1: [RESOLVED 2024-07-14 v1.2.3] SQL injection vulnerability in login endpoint`
  - Maintain the original finding description and resolution details
## Report Updates
On each update (adding findings, marking issues resolved, etc.):
1. Update the relevant finding/section
2. **Move resolved issues to appropriate resolved file**
3. **Recalculate the overall grade** (excluding resolved issues)
4. Update the grade in the report header/summary
5. This ensures the grade always reflects the current active state
## Resolved Issues File Structure
Both resolved files should maintain:
- Clear section headers by resolution date
- Original identifiers and descriptions
- Resolution details and version information
- Easy searchability for future reference
