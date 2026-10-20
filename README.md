# pr-reviewer

A focused Claude Code subagent that reviews your git diffs before opening a PR. Catches bugs, security issues, missing tests, and gives actionable feedback with file:line references.

## What it does
- **Smart diff detection** - Finds the right base branch (`main`/`master`) and reviews only changed files
- **Thorough review** - Flags critical bugs, security vulnerabilities, logic errors, and edge cases
- **Actionable feedback** - Organized into Critical / Suggestions / Nits with concrete fixes
- **Test coverage check** - Identifies missing tests for new/changed behavior
- **Fast and focused** - Reviews diffs efficiently without getting overwhelmed

## Installation

### Option 1: Global (available in all projects)
```bash
# From the repo root
mkdir -p ~/.claude/agents
cp agents/pr-reviewer.md ~/.claude/agents/
```

### Option 2: Project-specific (only this repo)
```bash
# In your project root
mkdir -p .claude/agents
cp agents/pr-reviewer.md .claude/agents/
```

### Option 3: One-liner (if downloaded)
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/pr-reviewer/main/agents/pr-reviewer.md -o ~/.claude/agents/pr-reviewer.md
```

## Usage

In Claude Code, just ask it to review before creating a PR:

```
Review my changes before I open a PR
```

Or be more specific:
```
Review the diff against main for security issues
```

Claude will automatically delegate to `pr-reviewer` when it sees review-related requests, or you can explicitly invoke it with the Task tool.

## Example Output

```markdown
### Summary
Changes add user authentication flow. Moderate risk - needs careful review of token handling.

### Critical
- `src/auth/token.ts:23` - Storing JWT in localStorage is vulnerable to XSS. Use httpOnly cookies.
- `src/api/users.ts:67` - Missing authorization check - any authenticated user can access other users' data.

### Suggestions
- `src/auth/middleware.ts:12` - Consider using constant-time comparison for tokens.
- `src/utils/validate.ts:5` - Add schema validation for request bodies.

### Nits
- `src/auth/login.ts:8` - Unused import `lodash`.

### Test Coverage
- Missing tests for: token refresh flow, expired token handling
- Suggested tests: test invalid token returns 401, test expired token refreshes correctly

### Verdict
REQUEST_CHANGES - Address critical security issues before merging.
```

## Tips
- Stage your changes (`git add`) for a cleaner review
- Make sure you're on a feature branch with a proper base branch (main/master)
- For large PRs, the reviewer will focus on high-risk areas first

## License
MIT
