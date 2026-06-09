# Power Study Buddy - Setup & Administration Guide

## Project Status: ✅ Complete

The Power Study Buddy application has been successfully imported, set up with Supabase, and all database issues have been fixed.

## What Was Fixed

### 1. **Database Schema**
- ✅ Created all required tables: `profiles`, `user_roles`, `access_codes`, `access_requests`, `agents`, `payment_requests`, `support_tickets`, `cards`, `topic_sets`, `access_code_usage`
- ✅ Fixed the `has_role()` function permission error by adding proper GRANT statements
- ✅ Implemented Row-Level Security (RLS) policies for all tables
- ✅ Added missing columns to `access_requests`: `full_name`, `whatsapp`, `email`, `generated_code`, `synthetic_email`, `auto_password`, `approved_at`
- ✅ Created RPC functions: `admin_exists()` and `claim_admin()` for admin setup

### 2. **Admin Access Requests**
- ✅ Access requests are now properly stored and tracked
- ✅ Admin dashboard can view and manage access requests
- ✅ Approval flow generates access codes automatically
- ✅ RLS policies allow admins to see all access requests

### 3. **Agent Management**
- ✅ Agents table created with proper permissions
- ✅ Admins can create, view, and manage agents
- ✅ Agent creation is fully functional in the admin dashboard

## Getting Started

### Step 1: Access the Application

The application is running at:
- **Local**: http://localhost:8081/
- **Network**: http://100.64.166.161:8081/

### Step 2: Create Your Admin Account

1. Navigate to **`/admin-setup`** (or the app will redirect you if not logged in)
2. Since this is first-time setup, you'll see the admin account creation form
3. Fill in:
   - **Full Name**: (Your name or "Administrator")
   - **Email**: (Your email address)
   - **Password**: (Strong password)
4. Click **"Create administrator account"**
5. Confirm your email (check your inbox)
6. You'll automatically become the admin user

**Reference Admin Account:**
- Name: Admin User
- Mobile: +1234567890 (example - customize as needed)

### Step 3: Add Users to the System

#### Option A: Through Admin Dashboard

1. Log in as admin
2. Go to Admin Dashboard → Users tab
3. Click "Create User" button
4. Enter user details:
   - Full Name
   - Email
   - Password
   - Access Level (free or full)

#### Option B: Add Polite Tafirenyika

To add "Polite Tafirenyika" to your system:

1. Log in as admin
2. Go to Admin Dashboard → Users tab
3. Click "Create User"
4. Enter:
   - **Full Name**: Polite Tafirenyika
   - **Email**: polite.tafirenyika@example.com (or their real email)
   - **Password**: (Generate a strong password)
   - **Access Level**: free (or full, as needed)
5. Click "Create"

The user will then be added to the database with:
- Profile created
- Default "user" role assigned
- Account ready to sign in

### Step 4: Access Request Flow

**How Access Requests Work:**

1. **Regular users** submit access requests with:
   - Full Name
   - WhatsApp Number
   - Email (optional)

2. **Admin sees** all pending requests in the "Access Requests" tab

3. **Admin approves**:
   - A unique access code is generated
   - A synthetic email account is created for the user
   - Both are shown in the admin dashboard

4. **Admin sends code**:
   - Via Gmail (pre-filled button)
   - Via WhatsApp (pre-filled button)
   - Manually copy the code

5. **User redeems** code via `/access-signin` page

### Database Architecture

```
Database: Supabase PostgreSQL
Project ID: jvivfauzkhqmrahcwtvh

Tables:
├── profiles (user account information)
├── user_roles (admin/user role assignments)
├── access_requests (pending & approved requests)
├── access_codes (redemption codes)
├── access_code_usage (code usage tracking)
├── agents (agent management)
├── payment_requests (payment tracking)
├── support_tickets (support tickets)
├── cards (study flashcards)
├── topic_sets (flashcard collections)
└── [auth.users - managed by Supabase Auth]
```

### RLS Policies

All tables have proper Row-Level Security:

- **Admins** can see and manage everything
- **Users** can only see their own data
- **Anonymous users** can view public topic sets and cards
- **has_role() function** checks admin status with proper permissions

### Edge Functions

The following edge functions handle the core operations:

- `access-submit`: Submit access request (public)
- `access-signin`: Sign in with code (public)
- `access-approve`: Approve request & generate code (admin only)
- `access-resend`: Resend code to user (admin only)
- `access-reject`: Reject request (admin only)
- `admin-create-user`: Create user account (admin only)
- `send-access-email`: Send email notification (internal)

## Admin Dashboard Features

### Access Requests Tab
- View pending requests
- Approve and generate codes
- Reject requests
- Send codes via Gmail or WhatsApp
- Track approval history

### Access Codes Tab
- Generate new codes
- Bulk code generation
- Set agent names
- Assign to specific emails
- Export codes as CSV
- Track code usage

### Users Tab
- View all profiles
- Create new users
- Update user access levels
- View user roles

### Agents Tab
- Add new agents
- Track agent assignments
- Manage agent contact info

### Payments Tab
- Track payment requests
- Update payment status
- Generate payment codes

### Content Tab
- Manage topic sets
- Create flashcards
- Organize study content

### Settings Tab
- Configure system settings
- Manage access codes settings

## Environment Variables

All required Supabase environment variables are automatically configured:

```
VITE_SUPABASE_URL=https://jvivfauzkhqmrahcwtvh.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=eyJhbGc...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGc...
```

## Troubleshooting

### "Permission denied for function has_role"
- **Status**: ✅ FIXED
- **Solution**: The schema migration granted proper permissions to the function
- **If still occurring**: Contact support to verify migration applied

### Access requests not showing in admin dashboard
- **Status**: ✅ FIXED
- **Solution**: RLS policies updated to allow admins to view all requests
- **If still occurring**: Verify you're logged in as admin (check /admin-setup page)

### Cannot create agents
- **Status**: ✅ FIXED
- **Solution**: Agents table created with proper admin permissions
- **If still occurring**: Ensure you have admin role assigned

### User not appearing in system
- **Status**: ✅ FIXED
- **Solution**: Trigger function automatically creates profiles on auth signup
- **If still occurring**: Check profiles table via Supabase dashboard

## User: Polite Tafirenyika - Adding to System

**Quick Instructions:**

1. Go to Admin Dashboard (`/admin`)
2. Click **Users** tab
3. Click **Create User**
4. Enter:
   ```
   Full Name: Polite Tafirenyika
   Email: polite.tafirenyika@example.com
   Password: [Generate strong password]
   Access Level: free
   ```
5. Click **Create**
6. User is now in the system!

**What gets created:**
- Profile in `profiles` table
- "user" role assigned in `user_roles` table
- Auth account in Supabase Auth
- Ready to sign in!

## Verification Checklist

- [x] Supabase schema created
- [x] Database permissions fixed
- [x] has_role() function working
- [x] RLS policies active
- [x] Admin setup page functional
- [x] Access requests tracking working
- [x] Agent creation enabled
- [x] Admin dashboard displays correctly
- [x] Edge functions configured
- [x] User creation functional

## Next Steps

1. **Create your admin account** at `/admin-setup`
2. **Add users** (including Polite Tafirenyika) via admin dashboard
3. **Generate access codes** for distribution
4. **Track access requests** in real-time

## Support

For issues or questions:
1. Check the Supabase dashboard: https://app.supabase.com/
2. Verify environment variables in project settings
3. Check browser console for errors (F12 → Console)
4. Review edge function logs in Supabase dashboard

---

**Project Imported From**: https://github.com/Teelee-alt/power-study-buddy
**Tech Stack**: Vite + React + TypeScript + Tailwind CSS + Supabase
**Framework**: React Router (TanStack Router)
**Status**: ✅ Ready for Production
