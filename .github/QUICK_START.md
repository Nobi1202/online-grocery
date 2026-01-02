# ⚡ Quick Start Guide

## 🎯 TL;DR - Get Started in 2 Minutes

### Step 1: Enable Permissions (Required)
```
Settings → Actions → General → Workflow permissions
✅ Read and write permissions
✅ Allow GitHub Actions to create and approve pull requests
```

### Step 2: Enable Wiki (Required)
```
Settings → Features
✅ Wikis
```

### Step 3: Create Labels (Optional)
```bash
gh label create "auto-created" --color "0E8A16"
gh label create "needs-review" --color "FBCA04"
```

### Step 4: Start Using!
```bash
git checkout -b feature/my-awesome-feature
git push origin feature/my-awesome-feature
# PR is auto-created! 🎉
```

---

## 🚀 What You Get

### ✅ Automatic PR Creation
Push to `feature/*`, `bugfix/*`, or `hotfix/*` → PR auto-created!

### ✅ PR Template
Every PR gets a structured template automatically

### ✅ Auto Wiki Updates
Merge PR → Wiki updated with:
- Changelog
- Features list
- Release notes

---

## 📋 Common Commands

### Create Feature Branch
```bash
git checkout -b feature/shopping-cart
git push origin feature/shopping-cart
```

### Create Bugfix Branch
```bash
git checkout -b bugfix/login-issue
git push origin bugfix/login-issue
```

### Create Hotfix Branch
```bash
git checkout -b hotfix/security-patch
git push origin hotfix/security-patch
```

---

## 🔍 Check Your Setup

### Verify Permissions
```bash
# Should show "Read and write"
gh api repos/:owner/:repo/actions/permissions
```

### Verify Wiki is Enabled
```bash
# Visit: https://github.com/YOUR_USERNAME/online_grocery/wiki
```

### Verify Labels (Optional)
```bash
gh label list
```

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| PR not created | Check branch name starts with `feature/`, `bugfix/`, or `hotfix/` |
| Permission error | Enable workflow permissions in Settings |
| Label error | Workflow works without labels! Create them for better organization |
| Wiki not updating | Enable wiki in repository settings |

---

## 📚 Full Documentation

- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** - Complete setup instructions
- **[LABELS_SETUP.md](LABELS_SETUP.md)** - How to create GitHub labels
- **[WORKFLOW_DIAGRAM.md](WORKFLOW_DIAGRAM.md)** - Visual flow diagrams
- **[README.md](README.md)** - Full documentation

---

## 💡 Pro Tips

1. **Use descriptive branch names** - They become PR titles
   ```bash
   ✅ feature/user-authentication
   ❌ feature/fix
   ```

2. **Fill out PR template** - Helps reviewers understand changes

3. **Check wiki after merge** - Verify documentation is accurate

4. **Use conventional commits** - Better changelog
   ```bash
   feat: add shopping cart
   fix: resolve login issue
   docs: update README
   ```

---

## 🎓 Example Workflow

```bash
# 1. Create feature branch
git checkout -b feature/payment-integration

# 2. Make changes
# ... code, code, code ...

# 3. Commit changes
git add .
git commit -m "feat: add payment integration"

# 4. Push (triggers PR creation)
git push origin feature/payment-integration

# 5. Go to GitHub → Pull Requests
# 6. Find your auto-created PR
# 7. Fill out the template
# 8. Request reviews
# 9. Merge when approved
# 10. Wiki is automatically updated! 🎉
```

---

## ✨ That's It!

You're ready to use the automated workflow system!

**Questions?** Check the full documentation or open an issue.

**Happy coding!** 🚀

