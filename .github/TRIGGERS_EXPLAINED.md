# 🎯 Triggers & Templates Explained

## 📝 Pull Request Template

### How It Works

The PR template is **automatically loaded** by GitHub when you create a PR.

### File Location

```
.github/pull_request_template.md  ✅ YOU HAVE THIS
```

**No additional setup needed!** GitHub automatically detects this file.

### When It's Used

The template appears when:
1. You create a PR manually via GitHub UI
2. The workflow auto-creates a PR for you
3. You use `gh pr create` command

### Alternative Locations (if needed)

GitHub checks these locations in order:
```
1. .github/pull_request_template.md          ← You're using this ✅
2. .github/PULL_REQUEST_TEMPLATE.md
3. docs/pull_request_template.md
4. PULL_REQUEST_TEMPLATE.md (in root)
```

### Multiple Templates (Advanced)

If you need different templates for different PR types:

```
.github/
  └── PULL_REQUEST_TEMPLATE/
      ├── feature_template.md
      ├── bugfix_template.md
      └── hotfix_template.md
```

Then specify when creating PR:
```bash
gh pr create --template feature_template.md
```

---

## 🔄 Workflow Triggers

### 1. Auto-Create PR Workflow

**File**: `.github/workflows/create-pr-on-feature-push.yml`

**Trigger Configuration**:

```yaml
on:
  push:
    branches:
      - 'feature/**'
      - 'bugfix/**'
      - 'hotfix/**'
```

**What This Means**:

| Action | Branch Pattern | Result |
|--------|---------------|--------|
| `git push origin feature/shopping-cart` | Matches `feature/**` | ✅ Workflow runs → PR created |
| `git push origin bugfix/login-crash` | Matches `bugfix/**` | ✅ Workflow runs → PR created |
| `git push origin hotfix/security-fix` | Matches `hotfix/**` | ✅ Workflow runs → PR created |
| `git push origin develop` | No match | ❌ Workflow doesn't run |
| `git push origin main` | No match | ❌ Workflow doesn't run |
| `git push origin random-branch` | No match | ❌ Workflow doesn't run |

**Trigger Flow**:

```
Developer pushes to feature/shopping-cart
           ↓
GitHub detects: "push to feature/** branch"
           ↓
Workflow: create-pr-on-feature-push.yml runs
           ↓
Checks if PR already exists
           ↓
If not exists: Creates PR with template
If exists: Adds comment about new commits
```

---

### 2. Update Wiki Workflow

**File**: `.github/workflows/update-wiki-on-pr-merge.yml`

**Trigger Configuration**:

```yaml
on:
  pull_request:
    types: [closed]
    branches:
      - main
```

**What This Means**:

| Action | Target Branch | PR Status | Result |
|--------|--------------|-----------|--------|
| Merge PR to `main` | main | merged | ✅ Workflow runs → Wiki updated |
| Close PR (not merged) to `main` | main | closed | ❌ Workflow skipped (check in job) |
| Merge PR to `develop` | develop | merged | ❌ Workflow doesn't run |

**Additional Check in Workflow**:

```yaml
if: github.event.pull_request.merged == true
```

This ensures the workflow **only runs when PR is merged**, not just closed.

**Trigger Flow**:

```
PR merged to main
       ↓
GitHub detects: "pull_request closed on main"
       ↓
Workflow: update-wiki-on-pr-merge.yml runs
       ↓
Checks: if PR was merged (not just closed)
       ↓
If merged: Updates wiki pages
If only closed: Skips execution
```

---

## 🎬 Complete Flow Diagram

### Scenario 1: Creating a Feature

```
Step 1: Developer creates branch
$ git checkout -b feature/user-auth
$ git push origin feature/user-auth

        ↓ TRIGGER: push to feature/**

Step 2: Workflow creates PR
✅ create-pr-on-feature-push.yml runs
✅ PR created with pull_request_template.md

Step 3: Developer sees PR
🌐 Opens GitHub → Pull Requests
📝 Template is already filled in
✏️  Completes the template sections

Step 4: Review & Merge
👥 Team reviews
✅ PR approved
🔀 Merge to main

        ↓ TRIGGER: pull_request closed on main

Step 5: Wiki updates
✅ update-wiki-on-pr-merge.yml runs
📚 Wiki pages updated automatically
```

### Scenario 2: Pushing More Commits

```
Step 1: PR already exists
(Created from previous push)

Step 2: Developer pushes new commits
$ git commit -m "Add more features"
$ git push origin feature/user-auth

        ↓ TRIGGER: push to feature/**

Step 3: Workflow adds comment
✅ create-pr-on-feature-push.yml runs
✅ Detects PR already exists
💬 Adds comment with commit info
```

---

## 📋 Trigger Types in GitHub Actions

### Available Trigger Types

| Trigger | When It Runs | Example Use Case |
|---------|-------------|------------------|
| `push` | Code pushed to branch | Auto-create PR |
| `pull_request` | PR opened/closed/etc | Run tests, update wiki |
| `pull_request_target` | PR from fork | Safe CI for forks |
| `workflow_dispatch` | Manual trigger | Deploy on demand |
| `schedule` | Cron schedule | Nightly builds |
| `release` | Release created | Publish packages |

### Pull Request Events

```yaml
on:
  pull_request:
    types:
      - opened        # PR created
      - synchronize   # New commits pushed
      - reopened      # PR reopened
      - closed        # PR closed or merged
      - labeled       # Label added
      - unlabeled     # Label removed
      - assigned      # Assignee added
```

---

## 🔧 Customizing Triggers

### Add More Branch Patterns

Edit `.github/workflows/create-pr-on-feature-push.yml`:

```yaml
on:
  push:
    branches:
      - 'feature/**'
      - 'bugfix/**'
      - 'hotfix/**'
      - 'enhancement/**'  # Add this
      - 'refactor/**'     # Add this
```

### Trigger on Different Target Branches

Edit `.github/workflows/update-wiki-on-pr-merge.yml`:

```yaml
on:
  pull_request:
    types: [closed]
    branches:
      - main
      - develop  # Add this to update wiki on develop merges too
```

### Add Manual Trigger

Add to any workflow:

```yaml
on:
  push:
    branches:
      - 'feature/**'
  workflow_dispatch:  # Adds "Run workflow" button in GitHub UI
```

### Exclude Certain Paths

Only trigger if specific files changed:

```yaml
on:
  push:
    branches:
      - 'feature/**'
    paths:
      - 'lib/**'           # Only trigger if lib/ files changed
      - '!lib/**/*.md'     # Exclude markdown files
```

---

## 🧪 Testing Triggers

### Test PR Template

1. Create a test branch:
   ```bash
   git checkout -b feature/test-template
   git push origin feature/test-template
   ```

2. Go to GitHub → Pull Requests → New PR
3. Template should appear automatically ✅

### Test Auto-Create PR Workflow

1. Push to feature branch:
   ```bash
   git checkout -b feature/test-workflow
   git push origin feature/test-workflow
   ```

2. Check Actions tab → Should see workflow running
3. Check Pull Requests → Should see auto-created PR

### Test Wiki Update Workflow

1. Create and merge a PR to main
2. Check Actions tab → Should see workflow running
3. Check Wiki → Should see new entries

---

## 📊 Monitoring Triggers

### View Workflow Runs

```bash
# List recent workflow runs
gh run list

# View specific run
gh run view <run-id>

# Watch a running workflow
gh run watch
```

### Check Trigger Events

In Actions tab, each run shows:
- **Event**: What triggered it (push, pull_request, etc.)
- **Branch**: Which branch triggered it
- **Commit**: Which commit triggered it

---

## 🐛 Troubleshooting Triggers

### PR Template Not Showing

**Check**:
1. File exists at `.github/pull_request_template.md` ✅
2. File is committed and pushed to repository
3. Creating PR from correct location

**Solution**:
```bash
# Verify file exists
ls -la .github/pull_request_template.md

# Make sure it's committed
git add .github/pull_request_template.md
git commit -m "Add PR template"
git push
```

### Workflow Not Triggering

**Check**:
1. Branch name matches pattern
2. Workflow file is in `.github/workflows/`
3. Workflow file has correct YAML syntax
4. Workflow permissions are enabled

**Debug**:
```bash
# Check workflow files
ls -la .github/workflows/

# Validate YAML syntax
cat .github/workflows/create-pr-on-feature-push.yml

# Check Actions tab for errors
```

### Workflow Runs But Fails

**Check**:
1. Actions tab → Click on failed run
2. Read error messages
3. Check permissions are enabled

**Common Issues**:
- Missing permissions → Enable in Settings
- Labels don't exist → Create labels or use updated workflow
- Wiki not enabled → Enable in Settings

---

## 📚 Summary

### PR Template
- **File**: `.github/pull_request_template.md`
- **Setup**: None needed (automatic)
- **When**: Every PR creation

### Auto-Create PR Workflow
- **File**: `.github/workflows/create-pr-on-feature-push.yml`
- **Trigger**: Push to `feature/**`, `bugfix/**`, `hotfix/**`
- **Action**: Creates PR with template

### Update Wiki Workflow
- **File**: `.github/workflows/update-wiki-on-pr-merge.yml`
- **Trigger**: PR merged to `main`
- **Action**: Updates wiki pages

---

## 🎓 Learn More

- [GitHub Actions Triggers](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)
- [PR Templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository)
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

---

**Everything is already set up correctly!** 🎉

Your PR template is working because the file is in the right location, and the workflows will trigger based on the branch patterns defined.

