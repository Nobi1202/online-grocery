# 🚀 GitHub Actions & Wiki Setup Guide

This guide explains the automated PR and wiki update system for the Online Grocery project.

## 📋 Overview

The project includes three automated workflows:

1. **Pull Request Template** - Provides a structured template for all PRs
2. **Auto-Create PR on Feature Push** - Automatically creates PRs when feature branches are pushed
3. **Update Wiki on PR Merge** - Updates GitHub wiki when PRs are merged to main

## 🔧 Setup Instructions

### 1. Enable GitHub Wiki

1. Go to your repository settings
2. Scroll down to the "Features" section
3. Check the "Wikis" option to enable it
4. The wiki will be automatically initialized when the first PR is merged

### 2. Configure Repository Permissions

The workflows require certain permissions to function:

1. Go to **Settings** → **Actions** → **General**
2. Under "Workflow permissions", select:
   - ✅ Read and write permissions
   - ✅ Allow GitHub Actions to create and approve pull requests
3. Click **Save**

### 3. Create GitHub Labels (Optional but Recommended)

The workflow works without labels, but creating them improves organization:

**Quick Setup via GitHub CLI:**
```bash
gh label create "auto-created" --description "PR was automatically created" --color "0E8A16"
gh label create "needs-review" --description "PR needs code review" --color "FBCA04"
```

📖 See [LABELS_SETUP.md](LABELS_SETUP.md) for detailed instructions and more label options.

### 4. Branch Protection Rules (Optional but Recommended)

To ensure quality, set up branch protection for `main`:

1. Go to **Settings** → **Branches**
2. Add rule for `main` branch:
   - ✅ Require pull request reviews before merging
   - ✅ Require status checks to pass before merging
   - ✅ Require branches to be up to date before merging

## 📝 How It Works

### Workflow 1: Pull Request Template

**File**: `.github/pull_request_template.md`

When creating a PR, GitHub automatically loads this template with sections for:
- Description
- Type of change
- Related issues
- Screenshots
- Testing checklist
- Platform testing

### Workflow 2: Auto-Create PR on Feature Push

**File**: `.github/workflows/create-pr-on-feature-push.yml`

**Triggers**: When you push to branches matching:
- `feature/**`
- `bugfix/**`
- `hotfix/**`

**Actions**:
1. Checks if a PR already exists for the branch
2. If not, creates a new PR to `main` with:
   - Auto-generated title from branch name
   - Labels: `auto-created`, `needs-review`
   - Basic PR body with branch information
3. If PR exists, adds a comment with new commit details

**Example**:
```bash
# Push to feature branch
git checkout -b feature/user-authentication
git push origin feature/user-authentication

# PR is automatically created with title: "[Feature] user-authentication"
```

### Workflow 3: Update Wiki on PR Merge

**File**: `.github/workflows/update-wiki-on-pr-merge.yml`

**Triggers**: When a PR is merged to `main`

**Actions**:
1. Clones the wiki repository
2. Updates three wiki pages:
   - **Changelog.md** - Chronological list of all merged PRs
   - **Features.md** - List of implemented features (for feature branches)
   - **Release-Notes.md** - Categorized changes (Added/Fixed/Changed)
3. Creates **Home.md** if it doesn't exist
4. Commits and pushes changes to wiki
5. Adds a comment to the merged PR with wiki links

## 🎯 Usage Examples

### Creating a Feature Branch

```bash
# Create and checkout feature branch
git checkout -b feature/shopping-cart

# Make your changes
git add .
git commit -m "Add shopping cart functionality"

# Push to remote - this triggers PR creation
git push origin feature/shopping-cart

# A PR is automatically created!
# Fill out the template in the PR description
```

### Working with Auto-Created PRs

1. Push your feature branch
2. Go to the Pull Requests tab
3. Find your auto-created PR
4. Fill out the template sections
5. Request reviews
6. Once approved and merged, wiki is automatically updated

### Viewing Wiki Updates

After merging a PR, check the wiki:

```
https://github.com/YOUR_USERNAME/online_grocery/wiki
```

You'll find:
- **Home** - Wiki homepage with navigation
- **Changelog** - All merged PRs with dates
- **Features** - Feature-specific documentation
- **Release Notes** - Organized by change type

## 🔍 Troubleshooting

### PR Not Created Automatically

**Check**:
1. Branch name matches pattern (`feature/`, `bugfix/`, `hotfix/`)
2. Workflow permissions are enabled
3. Check Actions tab for workflow run status

### Wiki Not Updating

**Check**:
1. Wiki is enabled in repository settings
2. Workflow has write permissions
3. PR was merged (not just closed)
4. Check Actions tab for error logs

### Workflow Fails with Permission Error

**Solution**:
1. Go to Settings → Actions → General
2. Enable "Read and write permissions"
3. Enable "Allow GitHub Actions to create and approve pull requests"

## 🛠️ Customization

### Modify PR Template

Edit `.github/pull_request_template.md` to add/remove sections.

### Change Branch Patterns

Edit `.github/workflows/create-pr-on-feature-push.yml`:

```yaml
on:
  push:
    branches:
      - 'feature/**'
      - 'enhancement/**'  # Add new pattern
      - 'bugfix/**'
```

### Customize Wiki Pages

Edit the wiki update logic in `.github/workflows/update-wiki-on-pr-merge.yml`:

```bash
# Add custom wiki pages
echo "Your content" > wiki/Custom-Page.md
```

### Add More Labels

Modify the PR creation step:

```yaml
gh pr create \
  --label "auto-created" \
  --label "needs-review" \
  --label "your-custom-label"
```

## 📊 Monitoring

### View Workflow Runs

1. Go to **Actions** tab
2. Select a workflow from the left sidebar
3. View run history and logs

### Workflow Status Badges

Add to your README.md:

```markdown
![Create PR](https://github.com/YOUR_USERNAME/online_grocery/workflows/Create%20PR%20on%20Feature%20Push/badge.svg)
![Update Wiki](https://github.com/YOUR_USERNAME/online_grocery/workflows/Update%20Wiki%20on%20PR%20Merge/badge.svg)
```

## 🎓 Best Practices

1. **Branch Naming**: Use descriptive names
   - ✅ `feature/user-authentication`
   - ✅ `bugfix/login-crash`
   - ❌ `feature/fix`

2. **Fill Out PR Template**: Complete all relevant sections

3. **Keep PRs Focused**: One feature/fix per PR

4. **Review Wiki Updates**: Check wiki after merging to ensure accuracy

5. **Use Conventional Commits**: Helps with automatic changelog generation
   ```
   feat: add shopping cart
   fix: resolve login issue
   docs: update README
   ```

## 🔐 Security Notes

- Workflows use `GITHUB_TOKEN` which is automatically provided
- No additional secrets needed for basic functionality
- Token has limited scope to repository only
- Wiki updates are done by `github-actions[bot]`

## 📚 Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Wiki Documentation](https://docs.github.com/en/communities/documenting-your-project-with-wikis)
- [Pull Request Templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests)

## 🤝 Contributing

When contributing to this project:

1. Create a feature branch
2. Let the workflow create the PR automatically
3. Fill out the PR template completely
4. Request reviews from team members
5. After merge, verify wiki updates

---

**Questions?** Open an issue or contact the maintainers.

