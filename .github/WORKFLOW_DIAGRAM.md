# 🔄 Automated Workflow Diagram

## Overview Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│                     Developer Workflow                               │
└─────────────────────────────────────────────────────────────────────┘

┌──────────────┐
│  Developer   │
│  Creates     │
│  Feature     │
│  Branch      │
└──────┬───────┘
       │
       │ git checkout -b feature/user-auth
       │ git push origin feature/user-auth
       │
       ▼
┌──────────────────────────────────────────────────────────────────┐
│  🤖 Workflow: create-pr-on-feature-push.yml                      │
│                                                                   │
│  Triggers on: push to feature/*, bugfix/*, hotfix/*             │
│                                                                   │
│  Actions:                                                         │
│  1. Check if PR already exists                                   │
│  2. If not exists:                                               │
│     ├─ Create PR to main                                         │
│     ├─ Add labels (auto-created, needs-review)                  │
│     └─ Use PR template                                           │
│  3. If exists:                                                   │
│     └─ Add comment with new commit info                         │
└──────────────────────────┬───────────────────────────────────────┘
                           │
                           ▼
                  ┌────────────────┐
                  │   Pull Request │
                  │   Created      │
                  │   with         │
                  │   Template     │
                  └────────┬───────┘
                           │
                           │ Developer fills template
                           │ Reviews approve
                           │ PR merged to main
                           │
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│  🤖 Workflow: update-wiki-on-pr-merge.yml                        │
│                                                                   │
│  Triggers on: PR merged to main                                  │
│                                                                   │
│  Actions:                                                         │
│  1. Extract PR information                                       │
│  2. Clone wiki repository                                        │
│  3. Update wiki pages:                                           │
│     ├─ Changelog.md (all PRs)                                   │
│     ├─ Features.md (feature branches)                           │
│     └─ Release-Notes.md (categorized)                           │
│  4. Create Home.md if not exists                                │
│  5. Commit and push to wiki                                     │
│  6. Add comment to PR with wiki links                           │
└──────────────────────────┬───────────────────────────────────────┘
                           │
                           ▼
                  ┌────────────────┐
                  │  GitHub Wiki   │
                  │  Updated       │
                  │  Automatically │
                  └────────────────┘
```

## Detailed Flow Diagram

### 1. Feature Development Flow

```
Developer                    GitHub Actions                  GitHub
────────                    ──────────────                  ──────

   │
   │ Create feature branch
   │ feature/shopping-cart
   │
   ├─────────────────────────────►
   │                              Check branch pattern
   │                              ├─ feature/* ✓
   │                              ├─ bugfix/* ✓
   │                              └─ hotfix/* ✓
   │
   │                              Check existing PR
   │                              └─ No PR found
   │
   │                              Create Pull Request
   │                              ├─ Title: [Feature] shopping-cart
   │                              ├─ Body: Auto-generated
   │                              ├─ Labels: auto-created, needs-review
   │                              └─ Template: Loaded
   │
   │◄─────────────────────────────
   │ PR Created Notification
   │
   │ Fill PR template
   │ Request reviews
   │
   │ Make more commits
   │
   ├─────────────────────────────►
   │                              PR already exists
   │                              Add comment with:
   │                              ├─ Commit SHA
   │                              ├─ Commit message
   │                              └─ Timestamp
   │
   │◄─────────────────────────────
   │ Comment added
   │
```

### 2. PR Merge and Wiki Update Flow

```
Developer                    GitHub Actions                  Wiki
────────                    ──────────────                  ────

   │
   │ PR approved
   │ Merge to main
   │
   ├─────────────────────────────►
   │                              PR merged event
   │                              
   │                              Extract PR info:
   │                              ├─ Number
   │                              ├─ Title
   │                              ├─ Author
   │                              ├─ Branch
   │                              └─ URL
   │
   │                              Clone wiki repo ──────────►
   │                                                         │
   │                              Update Changelog.md ──────┤
   │                              ├─ Add PR entry           │
   │                              └─ Chronological order    │
   │                                                         │
   │                              Update Features.md ───────┤
   │                              (if feature branch)       │
   │                              ├─ Extract feature name   │
   │                              └─ Add feature entry      │
   │                                                         │
   │                              Update Release-Notes.md ──┤
   │                              ├─ Categorize change      │
   │                              │  (Added/Fixed/Changed)  │
   │                              └─ Add to Unreleased      │
   │                                                         │
   │                              Create Home.md ───────────┤
   │                              (if not exists)           │
   │                                                         │
   │                              Commit & push ────────────►
   │                                                    Wiki Updated
   │
   │◄─────────────────────────────
   │ Comment on PR:
   │ "Wiki updated"
   │ + links to wiki pages
   │
```

## Branch Pattern Matching

```
┌─────────────────────────────────────────────────────────────┐
│  Branch Name                    Action                       │
├─────────────────────────────────────────────────────────────┤
│  feature/user-auth         ──►  Create PR + Update Wiki     │
│  feature/shopping-cart     ──►  Create PR + Update Wiki     │
│  bugfix/login-crash        ──►  Create PR + Update Wiki     │
│  hotfix/security-patch     ──►  Create PR + Update Wiki     │
│  develop                   ──►  No Action                   │
│  main                      ──►  No Action                   │
│  random-branch             ──►  No Action                   │
└─────────────────────────────────────────────────────────────┘
```

## Wiki Page Structure

```
GitHub Wiki
├── Home.md
│   ├── Welcome message
│   ├── Navigation links
│   └── Project overview
│
├── Changelog.md
│   ├── [2026-01-02] PR #123: Feature X
│   ├── [2026-01-01] PR #122: Bugfix Y
│   └── [2025-12-31] PR #121: Feature Z
│
├── Features.md
│   ├── user-authentication
│   ├── shopping-cart
│   └── payment-integration
│
└── Release-Notes.md
    ├── Unreleased
    │   ├── Added
    │   ├── Fixed
    │   └── Changed
    └── v1.0.0
        ├── Added
        ├── Fixed
        └── Changed
```

## State Transitions

```
┌──────────────┐
│ Feature      │
│ Branch       │
│ Created      │
└──────┬───────┘
       │
       │ Push
       ▼
┌──────────────┐      Already      ┌──────────────┐
│ Check PR     │─────Exists────────►│ Add Comment  │
│ Exists?      │                    │ to PR        │
└──────┬───────┘                    └──────────────┘
       │
       │ Not Exists
       ▼
┌──────────────┐
│ Create PR    │
│ with         │
│ Template     │
└──────┬───────┘
       │
       │ Fill & Review
       ▼
┌──────────────┐
│ PR Approved  │
└──────┬───────┘
       │
       │ Merge
       ▼
┌──────────────┐
│ Update Wiki  │
│ - Changelog  │
│ - Features   │
│ - Release    │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Complete     │
└──────────────┘
```

## Permissions Flow

```
┌─────────────────────────────────────────────────────────────┐
│  Repository Settings                                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌────────────────────────────────────────┐                │
│  │  Actions → General                      │                │
│  │  ┌──────────────────────────────────┐  │                │
│  │  │ Workflow Permissions             │  │                │
│  │  │ ✓ Read and write permissions     │  │                │
│  │  │ ✓ Allow PR creation              │  │                │
│  │  └──────────────────────────────────┘  │                │
│  └────────────────────────────────────────┘                │
│                                                              │
│  ┌────────────────────────────────────────┐                │
│  │  Features                               │                │
│  │  ┌──────────────────────────────────┐  │                │
│  │  │ ✓ Wikis                          │  │                │
│  │  └──────────────────────────────────┘  │                │
│  └────────────────────────────────────────┘                │
│                                                              │
└─────────────────────────────────────────────────────────────┘
                           │
                           │ Enables
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  Workflow Capabilities                                       │
├─────────────────────────────────────────────────────────────┤
│  ✓ Create pull requests                                     │
│  ✓ Add comments to PRs                                      │
│  ✓ Add labels to PRs                                        │
│  ✓ Clone wiki repository                                    │
│  ✓ Commit to wiki                                           │
│  ✓ Push to wiki                                             │
└─────────────────────────────────────────────────────────────┘
```

## Error Handling Flow

```
┌──────────────┐
│ Workflow     │
│ Triggered    │
└──────┬───────┘
       │
       ▼
┌──────────────┐      Fail      ┌──────────────┐
│ Check        │───────────────►│ Log Error    │
│ Permissions  │                │ Exit         │
└──────┬───────┘                └──────────────┘
       │
       │ Pass
       ▼
┌──────────────┐      Fail      ┌──────────────┐
│ Execute      │───────────────►│ Log Error    │
│ Actions      │                │ Notify       │
└──────┬───────┘                └──────────────┘
       │
       │ Success
       ▼
┌──────────────┐
│ Complete     │
└──────────────┘
```

## Timeline Example

```
Day 1
09:00 │ Developer creates feature/user-auth
09:01 │ ├─ Push to GitHub
09:02 │ ├─ Workflow: create-pr-on-feature-push.yml runs
09:03 │ └─ PR #123 created automatically
10:00 │ Developer fills PR template
11:00 │ Team reviews PR
      │
Day 2
14:00 │ PR approved
14:05 │ PR merged to main
14:06 │ ├─ Workflow: update-wiki-on-pr-merge.yml runs
14:07 │ ├─ Changelog.md updated
14:08 │ ├─ Features.md updated
14:09 │ ├─ Release-Notes.md updated
14:10 │ └─ Comment added to PR with wiki links
```

---

**Legend:**
- 🤖 = Automated workflow
- ✓ = Required/Enabled
- ──► = Process flow
- ├─ = Branch/Option
- └─ = Final step

