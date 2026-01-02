# 🏷️ GitHub Labels Setup

## Quick Fix

The workflow now works **without labels**, but for better organization, you can create them.

## Option 1: Create Labels via GitHub UI (Recommended)

1. Go to your repository on GitHub
2. Click on **Issues** tab
3. Click on **Labels** (next to Milestones)
4. Click **New label** button
5. Create these labels:

### Suggested Labels

| Label Name | Description | Color |
|------------|-------------|-------|
| `auto-created` | PR was automatically created by workflow | `#0E8A16` (green) |
| `needs-review` | PR needs code review | `#FBCA04` (yellow) |
| `feature` | New feature or request | `#a2eeef` (light blue) |
| `bugfix` | Bug fix | `#d73a4a` (red) |
| `hotfix` | Critical fix | `#B60205` (dark red) |
| `documentation` | Documentation updates | `#0075ca` (blue) |
| `enhancement` | Enhancement to existing feature | `#84b6eb` (light blue) |

## Option 2: Create Labels via GitHub CLI

Run these commands in your terminal:

```bash
# Navigate to your repository
cd /Users/tranvannguyen/Documents/sota_document_transfer/flutter_ref/online_grocery

# Create labels
gh label create "auto-created" --description "PR was automatically created by workflow" --color "0E8A16"
gh label create "needs-review" --description "PR needs code review" --color "FBCA04"
gh label create "feature" --description "New feature or request" --color "a2eeef"
gh label create "bugfix" --description "Bug fix" --color "d73a4a"
gh label create "hotfix" --description "Critical fix" --color "B60205"
gh label create "documentation" --description "Documentation updates" --color "0075ca"
gh label create "enhancement" --description "Enhancement to existing feature" --color "84b6eb"
```

## Option 3: Create Labels via Script

Save this as `create_labels.sh` and run it:

```bash
#!/bin/bash

# Array of labels: name|description|color
labels=(
  "auto-created|PR was automatically created by workflow|0E8A16"
  "needs-review|PR needs code review|FBCA04"
  "feature|New feature or request|a2eeef"
  "bugfix|Bug fix|d73a4a"
  "hotfix|Critical fix|B60205"
  "documentation|Documentation updates|0075ca"
  "enhancement|Enhancement to existing feature|84b6eb"
)

for label in "${labels[@]}"; do
  IFS='|' read -r name description color <<< "$label"
  gh label create "$name" --description "$description" --color "$color" 2>/dev/null || \
    echo "Label '$name' already exists or error occurred"
done

echo "✅ Labels setup complete!"
```

Run it:
```bash
chmod +x create_labels.sh
./create_labels.sh
```

## Verification

After creating labels, verify them:

```bash
gh label list
```

Or check in GitHub UI:
- Go to: `https://github.com/YOUR_USERNAME/online_grocery/labels`

## Current Workflow Behavior

The workflow has been updated to:
- ✅ Create PRs successfully **without** labels
- ✅ Try to add labels if they exist
- ✅ Skip labels gracefully if they don't exist
- ✅ Show warning messages for missing labels

So your workflow will work **immediately** even without creating labels!

## Benefits of Using Labels

Once labels are created, they help with:
- 🔍 **Filtering** - Quickly find PRs by type
- 📊 **Organization** - Better project management
- 🤖 **Automation** - Other workflows can use labels
- 📈 **Metrics** - Track PR types and statistics

## Troubleshooting

### "Label already exists" error
This is fine! It means the label is already created.

### Permission denied
Make sure you're authenticated with GitHub CLI:
```bash
gh auth login
```

### Can't find gh command
Install GitHub CLI:
```bash
# macOS
brew install gh

# Or download from: https://cli.github.com/
```

---

**Note**: The workflow will work fine without labels, but creating them improves organization and tracking.

