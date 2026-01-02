# 🔄 GitHub Workflows

This directory contains automated workflows for the Online Grocery project.

## 📁 Workflow Files

### CI/CD Workflows

- **`android-dev-ci.yml`** - Android development CI pipeline
- **`android-dev-cd.yml`** - Android development CD pipeline
- **`ios-dev-ci.yml`** - iOS development CI pipeline

### Automation Workflows

- **`create-pr-on-feature-push.yml`** - Auto-creates pull requests when feature branches are pushed
- **`update-wiki-on-pr-merge.yml`** - Updates GitHub wiki when PRs are merged to main

## 🚀 Quick Start

### For Developers

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes and push**:
   ```bash
   git add .
   git commit -m "Your commit message"
   git push origin feature/your-feature-name
   ```

3. **PR is automatically created!**
   - Go to the Pull Requests tab
   - Find your auto-created PR
   - Fill out the template
   - Request reviews

4. **After merge**:
   - Wiki is automatically updated
   - Check the wiki for your changes

### Branch Naming Conventions

Auto-PR creation works for these patterns:
- `feature/*` - New features
- `bugfix/*` - Bug fixes
- `hotfix/*` - Critical fixes

## 📊 Workflow Status

| Workflow | Status | Trigger |
|----------|--------|---------|
| Android Dev CI | ✅ | PR to develop/main |
| Android Dev CD | ✅ | Manual |
| iOS Dev CI | ✅ | PR to develop/main |
| Create PR | 🆕 | Push to feature/bugfix/hotfix branches |
| Update Wiki | 🆕 | PR merged to main |

## 🔧 Setup Required

Before using the automation workflows, ensure:

1. ✅ GitHub Wiki is enabled in repository settings
2. ✅ Workflow permissions set to "Read and write"
3. ✅ "Allow GitHub Actions to create and approve pull requests" is enabled

See [SETUP_GUIDE.md](../SETUP_GUIDE.md) for detailed instructions.

## 📝 Pull Request Template

A PR template is automatically loaded when creating pull requests. It includes:
- Description
- Type of change
- Related issues
- Screenshots
- Testing checklist
- Platform testing

## 📚 Wiki Pages

After merging PRs, the following wiki pages are updated:

- **Home** - Wiki homepage
- **Changelog** - All merged PRs chronologically
- **Features** - Implemented features list
- **Release Notes** - Categorized changes

## 🛠️ Customization

To customize workflows:

1. Edit the YAML files in this directory
2. Commit and push changes
3. Workflows will use the updated configuration

## 📖 Documentation

For detailed documentation, see:
- [Setup Guide](../SETUP_GUIDE.md) - Complete setup instructions
- [GitHub Actions Docs](https://docs.github.com/en/actions)

## 🐛 Troubleshooting

If workflows aren't working:

1. Check the Actions tab for error logs
2. Verify repository permissions
3. Ensure branch names match patterns
4. Check that wiki is enabled

## 💡 Tips

- Use descriptive branch names for better PR titles
- Fill out PR templates completely
- Review wiki updates after merging
- Use conventional commit messages

---

**Need help?** Check the [SETUP_GUIDE.md](../SETUP_GUIDE.md) or open an issue.

