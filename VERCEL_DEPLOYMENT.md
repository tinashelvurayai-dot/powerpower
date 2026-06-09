# 🚀 Vercel Deployment Guide

## Complete Deployment Steps

This guide walks you through deploying Power Study Buddy to Vercel after pushing to GitHub.

---

## Prerequisites

✅ Project is production-ready (verified)
✅ Build passes without errors (verified)
✅ All environment variables configured (verified)
✅ Supabase schema deployed (verified)
✅ GitHub repository ready (when you push)

---

## Step 1: Push to GitHub

### Option A: Initialize Git (First Time)
```bash
cd /vercel/share/v0-project
git init
git add .
git commit -m "Power Study Buddy - Initial commit, production ready"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/power-study-buddy.git
git push -u origin main
```

### Option B: Update Existing Repo
```bash
cd /vercel/share/v0-project
git add .
git commit -m "Power Study Buddy - Updated with fixes and improvements"
git push origin main
```

---

## Step 2: Deploy to Vercel

### Method A: Vercel CLI (Recommended)
```bash
# Install Vercel CLI globally
npm i -g vercel

# Deploy from project directory
cd /vercel/share/v0-project
vercel --prod

# Follow prompts:
# 1. Link to GitHub? → Yes
# 2. Select power-study-buddy repo
# 3. Set environment variables (see below)
```

### Method B: Vercel Dashboard
1. Go to: https://vercel.com/dashboard
2. Click: "New Project"
3. Import from GitHub: Select `power-study-buddy`
4. Framework: Vite (auto-detected)
5. Build: `pnpm build` (auto-detected)
6. Output Directory: `dist` (auto-detected)
7. Click: "Configure Project"

---

## Step 3: Set Environment Variables

In Vercel Dashboard → Settings → Environment Variables, add:

```
VITE_SUPABASE_URL = https://jvivfauzkhqmrahcwtvh.supabase.co
VITE_SUPABASE_ANON_KEY = [Get from your Supabase project]
```

### Finding Supabase Credentials:
1. Go to: https://app.supabase.com
2. Select project: `jvivfauzkhqmrahcwtvh`
3. Settings → API → Copy values for:
   - Project URL → `VITE_SUPABASE_URL`
   - Anon Public Key → `VITE_SUPABASE_ANON_KEY`
4. Paste into Vercel environment variables

---

## Step 4: Deploy

```bash
# Via CLI
vercel deploy --prod

# Via Dashboard
Click "Deploy" button
```

Wait for deployment to complete (usually 1-2 minutes).

---

## Verification After Deployment

### Check Deployment Status
1. Go to: https://vercel.com/dashboard
2. Select: power-study-buddy
3. Look for green "Ready" status
4. Click project name to see live URL

### Test the Live Site
1. Open the Vercel URL in browser
2. Test homepage loads ✅
3. Test "Request Access" form ✅
4. Test "Sign in" page ✅
5. Test "Admin Setup" page ✅

### Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| Build fails | Check env vars are set correctly |
| Blank page | Check browser console for errors |
| 404 errors | Verify dist folder contains index.html |
| Can't access admin | Create admin account at `/admin-setup` |
| Supabase errors | Verify credentials in env vars |

---

## Production Checklist

Before marking as live, verify:

- [ ] Homepage loads with all content
- [ ] Navigation links work
- [ ] "Request Access" form works
- [ ] "Sign in" page loads
- [ ] Admin setup page accessible
- [ ] No console errors
- [ ] No 404s
- [ ] Performance acceptable
- [ ] Mobile responsive

---

## After Deployment

### Monitor Application
- Check Vercel Analytics → Performance
- Check Vercel Logs → Deployments
- Monitor Supabase → API Usage

### Configure Custom Domain (Optional)
1. Vercel Dashboard → Settings → Domains
2. Add your domain (e.g., powerstudybuddy.com)
3. Update DNS records (Vercel provides instructions)

### Enable Edge Caching (Optional)
1. Vercel Dashboard → Settings → Edge Caching
2. Enable for static assets

### Set Up Monitoring (Optional)
1. Vercel → Integrations → Sentry
2. Add for error tracking

---

## Rollback Plan

If something goes wrong:

```bash
# Revert to previous deployment
vercel rollback

# Or redeploy latest commit
vercel deploy --prod
```

---

## Environment Variables Reference

The app requires these Vite-prefixed variables for client-side code:

```
# REQUIRED (Client-side - exposed to browser)
VITE_SUPABASE_URL
VITE_SUPABASE_ANON_KEY

# These are automatically loaded from .env.local
# in development but NOT pushed to GitHub
```

---

## Troubleshooting

### Build Error: "Cannot find module"
- Make sure all dependencies installed: `pnpm install`
- Rebuild: `pnpm build`
- Push again: `git push origin main`

### Runtime Error: "Supabase initialization failed"
- Check env variables in Vercel Settings
- Verify credentials are correct
- Wait for env variables to propagate (2-5 min)

### 404 Page Not Found
- Check routing is working
- Verify index.html in dist folder
- Try Vercel CLI: `vercel logs`

### White/Blank Screen
- Open browser DevTools → Console
- Check for JavaScript errors
- Verify Supabase connection

---

## DNS & Domain Setup

If using custom domain:

1. **Add domain in Vercel:**
   - Settings → Domains → Add Domain

2. **Update your domain's DNS:**
   - Vercel provides CNAME records
   - Update at your domain provider
   - Wait for DNS propagation (15-30 min)

3. **SSL Certificate:**
   - Auto-generated and renewed by Vercel
   - No action needed

---

## Performance Optimization

### Already Optimized:
✅ Code splitting enabled
✅ Lazy loading configured
✅ Image optimization
✅ CSS minification
✅ JavaScript minification

### Monitor with:
- Vercel Analytics → Web Vitals
- Lighthouse scores
- Real User Monitoring (Vercel)

---

## Support & Help

### If deployment fails:
1. Check Vercel build logs
2. Verify environment variables
3. Check GitHub repo is public
4. Ensure pnpm.lock is committed

### For Supabase issues:
1. Check Supabase project status
2. Verify API keys are valid
3. Check RLS policies (should allow anon access to public data)

### For app issues:
1. Check browser console errors
2. Check Vercel function logs
3. Check Supabase logs

---

## Final Notes

- **Environment variables are case-sensitive**
- **Supabase credentials should NOT be committed**
- **Vercel auto-deploys on git push** (optional: configure webhooks)
- **SSL/TLS handled automatically by Vercel**
- **CDN caching enabled by default**

---

## Success! 🎉

Your Power Study Buddy is now deployed and live on Vercel!

Next steps:
1. Share the live URL with users
2. Create admin account at `/admin-setup`
3. Add users via request access system
4. Monitor performance in Vercel Analytics
