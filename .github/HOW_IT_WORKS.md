# 🎯 How Everything Works Together

## 📝 PR Template - The Simple Part

### Your Current Setup ✅

```
online_grocery/
└── .github/
    └── pull_request_template.md  ← GitHub finds this automatically!
```

**That's it!** No configuration needed. GitHub automatically:
1. Detects this file
2. Loads it when you create any PR
3. Pre-fills the PR description with the template

### When You See The Template

**Scenario 1: Manual PR Creation**
```
You: Click "New Pull Request" on GitHub
GitHub: "Oh, they have a PR template!"
GitHub: *Loads .github/pull_request_template.md*
You: See the template already filled in ✨
```

**Scenario 2: Auto-Created PR**
```
You: git push origin feature/my-feature
Workflow: *Creates PR automatically*
Workflow: Uses template when creating PR
You: Open PR → Template is there ✨
```

**Scenario 3: CLI PR Creation**
```
You: gh pr create
GitHub CLI: "Let me check for a template..."
GitHub CLI: *Finds .github/pull_request_template.md*
You: Template opens in your editor ✨
```

---

## 🔄 Workflow Triggers - The Automated Part

### Workflow 1: Auto-Create PR

**File Location**:
```
.github/workflows/create-pr-on-feature-push.yml
```

**The Trigger Section**:
```yaml
on:
  push:                    # When code is pushed
    branches:              # To these branches:
      - 'feature/**'       # Any branch starting with feature/
      - 'bugfix/**'        # Any branch starting with bugfix/
      - 'hotfix/**'        # Any branch starting with hotfix/
```

**Real Example**:

```bash
# ✅ TRIGGERS WORKFLOW
git push origin feature/shopping-cart
git push origin feature/user/authentication
git push origin bugfix/login-error
git push origin hotfix/security-patch

# ❌ DOES NOT TRIGGER
git push origin main
git push origin develop
git push origin my-random-branch
git push origin feat/something    # Note: "feat" not "feature"
```

**What Happens**:

```
1. You push: git push origin feature/shopping-cart
              ↓
2. GitHub: "Someone pushed to feature/shopping-cart"
              ↓
3. GitHub: "Does this match my trigger patterns?"
              ↓
4. GitHub: "Yes! feature/** matches feature/shopping-cart"
              ↓
5. GitHub: "Run create-pr-on-feature-push.yml"
              ↓
6. Workflow: Check if PR exists
              ↓
7a. If NO PR exists:
    - Create new PR
    - Use pull_request_template.md
    - Add to main branch
              ↓
7b. If PR exists:
    - Add comment with commit info
              ↓
8. You: See PR on GitHub! 🎉
```

---

### Workflow 2: Update Wiki

**File Location**:
```
.github/workflows/update-wiki-on-pr-merge.yml
```

**The Trigger Section**:
```yaml
on:
  pull_request:            # When a pull request
    types: [closed]        # Is closed (merged or just closed)
    branches:              # On these branches:
      - main               # Only main branch
```

**Plus Additional Check**:
```yaml
if: github.event.pull_request.merged == true
```

**Real Example**:

```bash
# ✅ TRIGGERS WORKFLOW
Merge PR #5 to main (merged = true)

# ❌ DOES NOT TRIGGER
Close PR #5 without merging (merged = false)
Merge PR #5 to develop (not main branch)
```

**What Happens**:

```
1. You: Click "Merge pull request" on GitHub
              ↓
2. GitHub: "PR #5 was closed on main branch"
              ↓
3. GitHub: "Does this match my trigger?"
              ↓
4. GitHub: "Yes! pull_request + closed + main"
              ↓
5. GitHub: "Run update-wiki-on-pr-merge.yml"
              ↓
6. Workflow: Check if PR was merged (not just closed)
              ↓
7. If merged = true:
    - Clone wiki repository
    - Update Changelog.md
    - Update Features.md (if feature branch)
    - Update Release-Notes.md
    - Commit and push to wiki
    - Add comment to PR
              ↓
8. You: Check wiki → See updates! 🎉
```

---

## 🎬 Complete Real-World Example

### Day 1: Starting a Feature

```bash
# You create a feature branch
$ git checkout -b feature/shopping-cart
$ git commit -m "Initial shopping cart setup"
$ git push origin feature/shopping-cart
```

**What Happens**:

```
GitHub Actions Dashboard:
┌─────────────────────────────────────────┐
│ ✅ Create PR on Feature Push            │
│    Triggered by: push                   │
│    Branch: feature/shopping-cart        │
│    Status: Success                      │
│    Duration: 5s                         │
└─────────────────────────────────────────┘

Pull Requests:
┌─────────────────────────────────────────┐
│ #6 [Feature] shopping-cart              │
│ 🏷️  auto-created, needs-review          │
│                                         │
│ ## 🚀 Auto-generated Pull Request       │
│                                         │
│ This PR was automatically created...    │
│                                         │
│ [Your PR template sections here]        │
└─────────────────────────────────────────┘
```

---

### Day 2: Adding More Commits

```bash
# You continue working
$ git commit -m "Add cart items display"
$ git push origin feature/shopping-cart
```

**What Happens**:

```
GitHub Actions Dashboard:
┌─────────────────────────────────────────┐
│ ✅ Create PR on Feature Push            │
│    Triggered by: push                   │
│    Branch: feature/shopping-cart        │
│    Status: Success                      │
│    Duration: 3s                         │
└─────────────────────────────────────────┘

Pull Request #6:
┌─────────────────────────────────────────┐
│ [Your PR description]                   │
│                                         │
│ 💬 github-actions[bot] commented:       │
│                                         │
│ ## 🔄 New commits pushed                │
│                                         │
│ **Commit**: `a1b2c3d`                   │
│ **Message**: Add cart items display     │
│ **Pusher**: @YourUsername               │
│ **Time**: 2026-01-02 10:30:00 UTC       │
└─────────────────────────────────────────┘
```

---

### Day 3: Merging the PR

```bash
# On GitHub: Click "Merge pull request"
```

**What Happens**:

```
GitHub Actions Dashboard:
┌─────────────────────────────────────────┐
│ ✅ Update Wiki on PR Merge              │
│    Triggered by: pull_request (closed)  │
│    PR: #6                               │
│    Status: Success                      │
│    Duration: 8s                         │
└─────────────────────────────────────────┘

Wiki Updated:
┌─────────────────────────────────────────┐
│ 📚 Changelog.md                         │
│ ## [2026-01-02] PR #6: shopping-cart    │
│ - Author: @YourUsername                 │
│ - Branch: feature/shopping-cart         │
│ - Merged: 2026-01-02                    │
│                                         │
│ 📚 Features.md                          │
│ ### shopping-cart                       │
│ - PR: #6                                │
│ - Description: [Feature] shopping-cart  │
│                                         │
│ 📚 Release-Notes.md                     │
│ ## Unreleased                           │
│ - [Added] shopping-cart (#6)            │
└─────────────────────────────────────────┘

Pull Request #6:
┌─────────────────────────────────────────┐
│ 💬 github-actions[bot] commented:       │
│                                         │
│ ## 📚 Wiki Updated                      │
│                                         │
│ The GitHub wiki has been automatically  │
│ updated with information from this PR.  │
│                                         │
│ - View Changelog                        │
│ - View Features                         │
│ - View Release Notes                    │
└─────────────────────────────────────────┘
```

---

## 🔍 Behind The Scenes

### How GitHub Detects Triggers

```
Every time something happens in your repo:
    ↓
GitHub checks all workflow files
    ↓
For each workflow, checks the "on:" section
    ↓
If event matches trigger:
    ↓
    Runs the workflow
```

### Example: Push Event

```yaml
# Your workflow file
on:
  push:
    branches:
      - 'feature/**'
```

```
You: git push origin feature/cart
    ↓
GitHub: "Push event detected"
    ↓
GitHub: "Branch is feature/cart"
    ↓
GitHub: "Does feature/cart match feature/**?"
    ↓
GitHub: "Yes! The ** means any characters"
    ↓
GitHub: "Run this workflow"
```

### Pattern Matching

| Pattern | Matches | Doesn't Match |
|---------|---------|---------------|
| `feature/**` | `feature/cart`<br>`feature/user/auth`<br>`feature/a` | `feat/cart`<br>`features/cart`<br>`bugfix/cart` |
| `feature/*` | `feature/cart`<br>`feature/auth` | `feature/user/auth`<br>(no nested paths) |
| `main` | `main` only | `main-branch`<br>`develop` |
| `**` | Any branch | (matches all) |

---

## 📊 Visual Summary

### The Complete System

```
┌─────────────────────────────────────────────────────────┐
│                    YOUR REPOSITORY                       │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  📁 .github/                                            │
│    │                                                     │
│    ├── 📄 pull_request_template.md                     │
│    │   └─→ Used by: All PRs (automatic)               │
│    │                                                     │
│    └── 📁 workflows/                                    │
│         │                                                │
│         ├── 📄 create-pr-on-feature-push.yml           │
│         │   ├─ Trigger: push to feature/bugfix/hotfix  │
│         │   └─ Action: Create PR with template         │
│         │                                                │
│         └── 📄 update-wiki-on-pr-merge.yml             │
│             ├─ Trigger: PR merged to main              │
│             └─ Action: Update wiki pages               │
│                                                          │
└─────────────────────────────────────────────────────────┘

         ↓ When you push to feature branch

┌─────────────────────────────────────────────────────────┐
│              GITHUB ACTIONS EXECUTES                     │
├─────────────────────────────────────────────────────────┤
│  1. Detects push to feature/**                          │
│  2. Runs create-pr-on-feature-push.yml                  │
│  3. Creates PR using pull_request_template.md           │
└─────────────────────────────────────────────────────────┘

         ↓ When you merge PR to main

┌─────────────────────────────────────────────────────────┐
│              GITHUB ACTIONS EXECUTES                     │
├─────────────────────────────────────────────────────────┤
│  1. Detects PR closed on main                           │
│  2. Checks if merged (not just closed)                  │
│  3. Runs update-wiki-on-pr-merge.yml                    │
│  4. Updates wiki pages automatically                     │
└─────────────────────────────────────────────────────────┘
```

---

## ✅ Your Current Setup Status

### ✅ Working Right Now

1. **PR Template** - `.github/pull_request_template.md`
   - ✅ File exists
   - ✅ In correct location
   - ✅ Automatically used by GitHub

2. **Auto-Create PR Workflow** - `.github/workflows/create-pr-on-feature-push.yml`
   - ✅ File exists
   - ✅ Triggers on feature/bugfix/hotfix branches
   - ✅ Creates PRs with template
   - ✅ Fixed label issue (now works without labels)

3. **Update Wiki Workflow** - `.github/workflows/update-wiki-on-pr-merge.yml`
   - ✅ File exists
   - ✅ Triggers on PR merge to main
   - ✅ Updates wiki pages

### 🔧 Optional Improvements

- Create GitHub labels for better organization
- Enable branch protection rules
- Add more branch patterns if needed

---

## 🎓 Key Takeaways

1. **PR Template** = Simple file, automatic detection, no setup needed
2. **Workflow Triggers** = Defined in `on:` section of workflow YAML
3. **Branch Patterns** = Use `**` for wildcard matching
4. **Everything is already working!** 🎉

---

**Questions?** Check:
- [TRIGGERS_EXPLAINED.md](TRIGGERS_EXPLAINED.md) - Detailed trigger documentation
- [QUICK_START.md](QUICK_START.md) - Quick reference guide
- [SETUP_GUIDE.md](SETUP_GUIDE.md) - Complete setup instructions

