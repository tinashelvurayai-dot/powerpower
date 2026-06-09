# Deployment Guide - GitHub & Vercel

## Prerequisites
- GitHub account
- Vercel account
- Supabase project already configured (✅ Done)

---

## Step 1: Prepare for GitHub

### Initialize Git (if not already done)
```bash
cd /vercel/share/v0-project
git init
git add .
git commit -m "Initial commit: Power Study Buddy - Imported and configured"
```

### Create .gitignore
```bash
# Standard Node.js ignores
node_modules/
.env.local
.env.*.local
dist/
.DS_Store
*.log
.turbo/

# Vite
.vite/
```

---

## Step 2: Push to GitHub

### Method A: Using GitHub Web UI
1. Create new repository on github.com (without README)
2. Get the repository URL (e.g., `https://github.com/username/power-study-buddy.git`)
3. Add remote and push:
```bash
git remote add origin https://github.com/username/power-study-buddy.git
git branch -M main
git push -u origin main
```

### Method B: Using GitHub CLI (gh)
```bash
gh repo create power-study-buddy --public --source=. --remote=origin --push
```

---

## Step 3: Deploy to Vercel

### Option A: Direct Git Integration (Recommended)
1. Go to [vercel.com/new](https://vercel.com/new)
2. Click "Continue with GitHub"
3. Select your `power-study-buddy` repository
4. Configure project:
   - **Framework Preset**: Vite
   - **Root Directory**: ./
   - **Build Command**: `pnpm build`
   - **Output Directory**: `dist`

### Option B: Vercel CLI
```bash
# Install Vercel CLI
npm i -g vercel

# Login to Vercel
vercel login

# Deploy
cd /vercel/share/v0-project
vercel
```

---

## Step 4: Set Environment Variables in Vercel

1. Go to Vercel Dashboard → Your Project → Settings
2. Click "Environment Variables"
3. Add the following variables:

| Key | Value |
|-----|-------|
| `VITE_SUPABASE_URL` | `https://jvivfauzkhqmrahcwtvh.supabase.co` |
| `VITE_SUPABASE_ANON_KEY` | *(get from Supabase → Settings → API Keys)* |

4. Make sure these are available in all environments (Production, Preview, Development)

---

## Step 5: Verify Deployment

1. Vercel will show your deployment URL (e.g., `https://power-study-buddy.vercel.app`)
2. Click the link to visit your live app
3. Test:
   - ✅ Homepage loads
   - ✅ Sign in page accessible
   - ✅ Admin setup page accessible at `/admin-setup`
   - ✅ Request Access form works
   - ✅ Create admin account and access admin dashboard

---

## Step 6: Production Checklist

Before going live:

- [ ] Admin account created and tested
- [ ] Test user "Polite Tafirenyika" added
- [ ] Access request submission tested
- [ ] Admin approval flow tested
- [ ] Access code generation verified
- [ ] Offline functionality (PWA) works
- [ ] Mobile responsive design verified
- [ ] All links working correctly
- [ ] Environment variables set in Vercel

---

## Continuous Deployment

Vercel automatically deploys when you push to GitHub:

```bash
# Make changes locally
git add .
git commit -m "Describe your changes"
git push origin main

# Vercel automatically deploys to production
# Check deployment status at: vercel.com/dashboard
```

### Deploy to Preview
To test before production:
```bash
git checkout -b feature-branch
# Make changes
git push origin feature-branch

# Vercel creates a preview deployment
# Link available in GitHub PR
```

---

## Troubleshooting Deployment

### Build fails with "cannot find module"
- ✅ Run `pnpm install` locally first
- ✅ Commit `pnpm-lock.yaml`
- ✅ Ensure Node.js version is 18+ in Vercel

### Environment variables not working
- ✅ Verify added in Vercel Settings
- ✅ Rebuild after adding variables: `Vercel → Deployments → Redeploy`
- ✅ Check variable names match (case-sensitive)

### Supabase connection failing
- ✅ Verify `VITE_SUPABASE_URL` is correct
- ✅ Verify `VITE_SUPABASE_ANON_KEY` is correct
- ✅ Check Supabase project is active
- ✅ In browser console: `console.log(import.meta.env.VITE_SUPABASE_URL)`

### Admin setup page shows blank
- ✅ Check network tab for API errors
- ✅ Verify Supabase integration is connected
- ✅ Check browser console for JavaScript errors

---

## After Deployment

### Update DNS (if using custom domain)
1. Go to Vercel → Domains
2. Add custom domain
3. Update DNS records at your domain provider
4. Vercel provides SSL automatically via Let's Encrypt

### Monitor Performance
- Vercel Analytics: Dashboard → Analytics
- Check Core Web Vitals
- Monitor error rates

### Backup Supabase
1. Go to Supabase → Database → Backups
2. Enable automatic backups
3. Download manual backups weekly

---

## Quick Reference

| Task | Command |
|------|---------|
| Deploy to GitHub | `git push origin main` |
| Deploy to Vercel | Automatic via GitHub, or `vercel` CLI |
| View live app | Click Vercel dashboard link |
| Redeploy | `Vercel Dashboard → Deployments → Redeploy` |
| Check logs | `Vercel Dashboard → Logs` |
| Set env vars | `Vercel Dashboard → Settings → Environment Variables` |

---

## Support

For issues:
- **Vercel**: [vercel.com/support](https://vercel.com/support)
- **Supabase**: [supabase.com/docs](https://supabase.com/docs)
- **GitHub**: [github.com/support](https://github.com/support)

---

## ✅ You're Ready!

Your Power Study Buddy app is ready for:
1. ✅ Local development
2. ✅ GitHub version control
3. ✅ Vercel continuous deployment
4. ✅ Production use

Good luck! 🚀
