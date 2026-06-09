# Power Study Buddy

A modern study application for exam preparation with offline-first PWA support, built on Vite + React + Supabase.

## Features

- 📚 **400+ Exam Questions** - Based on real National Diploma past papers
- 🎯 **Flip-Card Learning** - Interactive spaced repetition
- 🔐 **Secure Access Control** - Admin-managed user provisioning
- 💰 **Agent Payment System** - Cash payment tracking and code generation
- 👥 **Admin Dashboard** - Manage users, agents, and access codes
- 📱 **PWA Support** - Works offline on desktop and mobile
- 🚀 **Fast & Responsive** - Built with Vite for instant development

## Technology Stack

- **Frontend**: React 19 + TypeScript + Tailwind CSS
- **Build Tool**: Vite
- **Backend**: Supabase (PostgreSQL + Auth + Edge Functions)
- **Hosting**: Vercel
- **Version Control**: GitHub

## Quick Start

### Local Development

```bash
# Install dependencies
pnpm install

# Start development server
pnpm dev

# The app will open at http://localhost:8080
```

### First Time Setup

1. **Create Admin Account**
   - Visit: `http://localhost:8080/admin-setup`
   - Fill in your details
   - Click "Create administrator account"

2. **Access Admin Dashboard**
   - Sign in with your admin account
   - Go to: `http://localhost:8080/admin`

3. **Add Users**
   - Share the homepage link with students
   - Students click "Request Access" to submit applications
   - Review and approve in admin dashboard
   - Generated access codes appear automatically

## Project Structure

```
├── src/
│   ├── routes/          # Page components
│   ├── components/      # Reusable components
│   ├── lib/             # Utilities and helpers
│   ├── hooks/           # Custom React hooks
│   ├── integrations/    # External service integration
│   ├── styles.css       # Global styles (Tailwind v4)
│   └── main.tsx         # App entry point
│
├── supabase/
│   ├── migrations/      # Database schema
│   └── functions/       # Edge functions
│
├── public/              # Static assets
├── vite.config.ts       # Vite configuration
├── tsconfig.json        # TypeScript configuration
├── package.json         # Dependencies and scripts
├── tailwind.config.ts   # Tailwind CSS config
│
└── README.md            # This file
```

## Environment Variables

Create a `.env.local` file (or set in Vercel):

```env
VITE_SUPABASE_URL=https://your-project-id.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
```

Get these values from your Supabase project settings.

## Build & Deploy

### Build for Production

```bash
pnpm build
pnpm preview  # Test production build locally
```

### Deploy to Vercel

See [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) for detailed instructions.

Quick deploy:
```bash
vercel deploy
```

## Documentation

- **[IMPLEMENTATION_COMPLETE.md](./IMPLEMENTATION_COMPLETE.md)** - Complete feature overview and setup instructions
- **[DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)** - GitHub & Vercel deployment guide
- **[ADMIN_DASHBOARD_GUIDE.md](./ADMIN_DASHBOARD_GUIDE.md)** - Admin dashboard features
- **[SETUP_GUIDE.md](./SETUP_GUIDE.md)** - Initial setup and configuration

## Admin Functions

### Dashboard Access
- URL: `/admin`
- Only admin users can access (Role-Based Access Control via `has_role()`)

### Key Capabilities
- ✅ View access requests
- ✅ Generate and manage access codes
- ✅ Manage payment agents
- ✅ Track payment notifications
- ✅ Add additional admins
- ✅ View system logs

## User Flows

### Student Access
1. Visit homepage
2. Click "Request Access"
3. Submit full name + WhatsApp number
4. Admin approves request
5. Admin generates access code
6. Student signs in with code
7. Full access unlocked

### Agent Payment
1. Student gives $5 to authorized agent
2. Agent notifies admin
3. Admin tracks payment
4. Admin generates code
5. Agent gives code to student
6. Student signs in

## Key Technologies Explained

### Vite
Fast build tool and dev server. Replaces webpack/Next.js for this project.

### Supabase
Backend-as-a-Service providing:
- PostgreSQL database
- Built-in authentication
- Row-Level Security (RLS)
- Edge Functions (serverless)
- Real-time subscriptions

### Tailwind CSS v4
Modern utility-first CSS framework bundled with `@tailwindcss/vite`.

## Database Schema

Core tables:
- **profiles** - User information and access levels
- **user_roles** - Admin/user role assignments
- **access_requests** - Student access applications
- **access_codes** - Generated codes and redemptions
- **agents** - Payment agent information
- **payment_requests** - Payment tracking

See migrations in `supabase/migrations/` for full schema.

## Security

- ✅ Row-Level Security (RLS) on all tables
- ✅ Role-based access control (admin/user)
- ✅ Secure password hashing (Supabase Auth)
- ✅ CSRF protection
- ✅ XSS prevention (React built-in)
- ✅ SQL injection prevention (parameterized queries)

## Performance

- 📦 Vite lazy-loads code automatically
- ⚡ Tailwind CSS v4 tree-shaking
- 📱 PWA for offline access
- 🎯 Optimized images and assets
- 🚀 Edge deployment with Vercel

## Browser Support

- ✅ Chrome/Edge (latest)
- ✅ Firefox (latest)
- ✅ Safari (latest)
- ✅ Mobile browsers (iOS Safari, Chrome Mobile)

## Scripts

```bash
pnpm dev      # Start dev server
pnpm build    # Build for production
pnpm preview  # Preview production build
pnpm lint     # Run ESLint
pnpm format   # Format with Prettier
```

## Troubleshooting

### Issue: "Cannot find module '@supabase/supabase-js'"
```bash
pnpm install
```

### Issue: Supabase connection failing
- Verify environment variables are set
- Check Supabase project is active
- Ensure API key has correct permissions

### Issue: Admin dashboard is blank
- Log out and back in
- Check browser console for errors
- Verify you're signed in as admin

### Issue: Vite dev server not starting
```bash
pkill -f vite
pnpm dev
```

## Contributing

1. Clone the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make changes and commit: `git commit -m "Add feature"`
4. Push to GitHub: `git push origin feature/your-feature`
5. Open a Pull Request

## License

This project is proprietary software. All rights reserved.

## Contact

For support or questions, contact the development team.

---

## ✅ Status

- ✅ Project imported and configured
- ✅ Supabase schema deployed
- ✅ Admin dashboard functional
- ✅ Access control system working
- ✅ Ready for production deployment

**Next Step**: Push to GitHub and deploy to Vercel (see [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md))

🚀 **Ready for Production**
