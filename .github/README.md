# 🤖 GitHub Automation Setup

This directory contains all GitHub-related automation and templates for the Online Grocery project.

## 📁 Directory Structure

```
.github/
├── README.md                           # This file
├── SETUP_GUIDE.md                      # Detailed setup instructions
├── WORKFLOW_DIAGRAM.md                 # Visual workflow diagrams
├── pull_request_template.md            # PR template
└── workflows/
    ├── README.md                       # Workflows overview
    ├── android-dev-ci.yml             # Android CI
    ├── android-dev-cd.yml             # Android CD
    ├── ios-dev-ci.yml                 # iOS CI
    ├── create-pr-on-feature-push.yml  # Auto-create PRs
    └── update-wiki-on-pr-merge.yml    # Auto-update wiki
```

## 🚀 Quick Start

### ⚡ 2-Minute Setup

1. **Enable Permissions**: Settings → Actions → General
   - ✅ Read and write permissions
   - ✅ Allow GitHub Actions to create and approve pull requests

2. **Enable Wiki**: Settings → Features → Check "Wikis"

3. **Create Labels** (optional): 
   ```bash
   gh label create "auto-created" --color "0E8A16"
   gh label create "needs-review" --color "FBCA04"
   ```

4. **Start using**:
   ```bash
   git checkout -b feature/my-feature
   git push origin feature/my-feature
   # PR auto-created! 🎉
   ```

📖 See [QUICK_START.md](QUICK_START.md) for step-by-step guide or [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed instructions.

### For Daily Development

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   git push origin feature/your-feature-name
   ```

2. **PR is auto-created** - Go to Pull Requests tab and fill out the template

3. **After merge** - Wiki is automatically updated

## 🎯 What's Automated?

### ✅ Pull Request Creation
- **Trigger**: Push to `feature/*`, `bugfix/*`, or `hotfix/*` branches
- **Action**: Automatically creates PR to `main` with template
- **Benefits**: Saves time, ensures consistency

### ✅ Wiki Updates
- **Trigger**: PR merged to `main`
- **Action**: Updates Changelog, Features, and Release Notes
- **Benefits**: Always up-to-date documentation

### ✅ PR Template
- **Trigger**: Creating any PR
- **Action**: Loads structured template
- **Benefits**: Consistent PR format, better reviews

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [QUICK_START.md](QUICK_START.md) | ⚡ 2-minute setup guide - Start here! |
| [HOW_IT_WORKS.md](HOW_IT_WORKS.md) | 🎯 How PR template & triggers work |
| [TRIGGERS_EXPLAINED.md](TRIGGERS_EXPLAINED.md) | 🔄 Detailed trigger documentation |
| [SETUP_GUIDE.md](SETUP_GUIDE.md) | 🔧 Complete setup instructions |
| [LABELS_SETUP.md](LABELS_SETUP.md) | 🏷️ How to create GitHub labels |
| [WORKFLOW_DIAGRAM.md](WORKFLOW_DIAGRAM.md) | 📊 Visual diagrams of flows |
| [workflows/README.md](workflows/README.md) | 📝 Workflow-specific docs |

## 🔄 Workflow Overview

```
Feature Branch Push
        ↓
  Auto-Create PR
        ↓
   Fill Template
        ↓
    Review & Approve
        ↓
   Merge to Main
        ↓
  Auto-Update Wiki
```

## 🛠️ Available Workflows

| Workflow | File | Trigger | Purpose |
|----------|------|---------|---------|
| Android Dev CI | `android-dev-ci.yml` | PR to develop/main | Build & test Android |
| Android Dev CD | `android-dev-cd.yml` | Manual | Deploy Android |
| iOS Dev CI | `ios-dev-ci.yml` | PR to develop/main | Build & test iOS |
| **Create PR** | `create-pr-on-feature-push.yml` | Push to feature branches | Auto-create PRs |
| **Update Wiki** | `update-wiki-on-pr-merge.yml` | PR merged to main | Update documentation |

## 📝 Pull Request Template

Located at: `pull_request_template.md`

Includes sections for:
- Description
- Type of change
- Related issues
- Screenshots
- Testing checklist
- Platform testing
- Additional notes

## 📖 Wiki Pages Generated

After merging PRs, these wiki pages are maintained:

- **Home.md** - Wiki homepage with navigation
- **Changelog.md** - Chronological list of all merged PRs
- **Features.md** - List of implemented features
- **Release-Notes.md** - Categorized changes (Added/Fixed/Changed)

## 🎨 Branch Naming Convention

For auto-PR creation to work, use these patterns:

| Pattern | Purpose | Example |
|---------|---------|---------|
| `feature/*` | New features | `feature/user-authentication` |
| `bugfix/*` | Bug fixes | `bugfix/login-crash` |
| `hotfix/*` | Critical fixes | `hotfix/security-patch` |

## 💡 Tips & Best Practices

1. **Use descriptive branch names** - They become PR titles
   ```bash
   ✅ feature/shopping-cart-checkout
   ❌ feature/fix
   ```

2. **Fill out PR templates completely** - Helps reviewers understand changes

3. **Review wiki after merging** - Ensure documentation is accurate

4. **Use conventional commits** - Better changelog generation
   ```bash
   feat: add shopping cart
   fix: resolve login issue
   docs: update README
   ```

5. **Keep PRs focused** - One feature/fix per PR

## 🔍 Monitoring

### View Workflow Runs
1. Go to **Actions** tab
2. Select a workflow
3. View run history and logs

### Workflow Status Badges

Add to your README.md:

```markdown
![Create PR](https://github.com/YOUR_USERNAME/online_grocery/workflows/Create%20PR%20on%20Feature%20Push/badge.svg)
![Update Wiki](https://github.com/YOUR_USERNAME/online_grocery/workflows/Update%20Wiki%20on%20PR%20Merge/badge.svg)
```

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| PR not created | Check branch name matches pattern |
| Wiki not updating | Ensure wiki is enabled in settings |
| Permission errors | Enable workflow permissions in settings |
| Workflow not running | Check Actions tab for error logs |

See [SETUP_GUIDE.md](SETUP_GUIDE.md#-troubleshooting) for detailed troubleshooting.

## 🔐 Security

- Uses `GITHUB_TOKEN` (automatically provided)
- No additional secrets required
- Limited scope to repository only
- Wiki updates by `github-actions[bot]`

## 🤝 Contributing

When contributing:
1. Create a feature branch with proper naming
2. Let automation create the PR
3. Fill out the PR template
4. Request reviews
5. After merge, verify wiki updates

## 📞 Support

- **Setup Issues**: See [SETUP_GUIDE.md](SETUP_GUIDE.md)
- **Workflow Questions**: See [workflows/README.md](workflows/README.md)
- **Visual Reference**: See [WORKFLOW_DIAGRAM.md](WORKFLOW_DIAGRAM.md)
- **Bug Reports**: Open an issue

## 🎓 Learning Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Wiki Documentation](https://docs.github.com/en/communities/documenting-your-project-with-wikis)
- [Pull Request Best Practices](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests)

## 📊 Workflow Statistics

Track your automation:
- Number of auto-created PRs
- Wiki update frequency
- Average PR merge time
- CI/CD success rate

View in the Actions tab.

## 🔄 Updates & Maintenance

To update workflows:
1. Edit YAML files in `workflows/` directory
2. Commit and push changes
3. New configuration takes effect immediately

## ✨ Features

- ✅ Automatic PR creation
- ✅ Structured PR templates
- ✅ Automatic wiki updates
- ✅ Changelog generation
- ✅ Feature tracking
- ✅ Release notes management
- ✅ CI/CD pipelines
- ✅ Multi-platform support

---

**Made with ❤️ for better development workflow**

For questions or suggestions, open an issue or contact the maintainers.

