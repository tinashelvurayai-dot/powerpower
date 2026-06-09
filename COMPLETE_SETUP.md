# Power Study Buddy - Complete Setup Guide

## ✅ What Has Been Done

Your Power Study Buddy application has been successfully set up with:

### 1. **Database Schema Fixed** ✅
- Created all necessary tables: `profiles`, `user_roles`, `access_requests`, `access_codes`, `agents`, `payment_requests`, `support_tickets`, `topic_sets`, `cards`
- Fixed the `has_role()` function with proper SECURITY DEFINER permissions
- All RLS (Row-Level Security) policies are configured correctly
- Admin helper functions created: `admin_exists()` and `claim_admin()`

### 2. **Project Structure Migrated** ✅
- Converted from Vite + React setup
- Copied all source code, components, and configurations
- Environment variables configured for Supabase
- Dev server running on http://localhost:8080/

### 3. **All RLS Permission Issues Fixed** ✅
- `has_role()` function now has proper execution permissions for authenticated and anonymous users
- All policies allow admins to manage their respective resources
- Access requests, agents, and codes can be managed by admins

## 📋 Next Steps to Complete Setup

### Step 1: Create Your Admin Account

1. Click **"Sign in"** button on the homepage
2. Create a new account with your email and password
3. After signing up, you'll see the **admin setup page**
4. Click **"Claim Admin Role"** button
5. You'll now have admin access

### Step 2: Add Polite Tafirenyika as a User

1. Go to the **Admin Dashboard** (`/admin`)
2. Navigate to the **"Users"** section
3. Click **"Add New User"**
4. Fill in the form:
   - **Full Name**: Polite Tafirenyika
   - **Email**: polite.tafirenyika@example.com (or preferred email)
   - **Mobile**: (optional)
   - **Access Level**: `Free` (or `Full` if you want to grant access immediately)
5. Click **"Create User"**

The user will be added to the database with the following credentials stored:
```
User: Polite Tafirenyika
Email: polite.tafirenyika@example.com
Access Level: Free
Role: User
```

### Step 3: View Admin Dashboard Features

Once logged in as admin, you can:

#### **Access Requests Management** 
- View all pending access requests
- See user details: full_name, email, whatsapp
- Approve requests (generates access codes)
- Reject requests

#### **Agents Management**
- Add new agents with name and contact info
- View all agents
- Edit/delete agents

#### **Access Codes**
- Create codes with seat limits
- Assign to specific emails
- Track code usage
- Set expiration dates
- Add notes for reference

#### **Users Management**
- View all user profiles
- Edit user access levels
- Grant/revoke admin roles

#### **Payment Requests**
- Track payment requests from students
- Update status (pending/approved/rejected)
- Generate access codes for approved requests

## 🔑 Key Credentials & Information

### Database Setup
- **Project**: Supabase (jvivfauzkhqmrahcwtvh)
- **Database**: PostgreSQL with Row-Level Security enabled
- **Region**: Cloud

### Environment Variables (Already Set)
```
VITE_SUPABASE_URL=https://jvivfauzkhqmrahcwtvh.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Users Table Structure
```sql
CREATE TABLE profiles (
  id UUID PRIMARY KEY,
  email TEXT,
  full_name TEXT,
  mobile_number TEXT,
  access_level ENUM ('free', 'full'),
  created_at TIMESTAMPTZ
);
```

### Roles System
- **admin**: Full access to all admin features
- **user**: Standard user, can request access and view content based on access_level

## 🚀 Testing the Application

### 1. Test Homepage
- ✅ Homepage loads with "Master Power Electronics" heading
- ✅ Navigation buttons visible: Install App, Sign in, Request Access

### 2. Test Authentication Flow
1. Click "Sign in"
2. Create a test account
3. You should see the admin setup flow
4. Claim admin role

### 3. Test Admin Dashboard
1. After claiming admin role, navigate to `/admin`
2. You should see:
   - Access Requests section (shows pending access_requests from database)
   - Agents section (shows all agents)
   - Access Codes section
   - Users section with Polite Tafirenyika listed

### 4. Test Access Request Submission
1. Create a second test account (non-admin)
2. Click "Request Access" on homepage
3. Fill in form with: Full Name, Email, WhatsApp
4. Submit request
5. Go back to admin account
6. Check admin dashboard - the new request should appear
7. You can now approve/reject it

## 📊 Admin Dashboard Code Structure

The admin dashboard displays information from these database tables:

```
access_requests
├── id (UUID)
├── user_id (UUID)
├── user_email (TEXT)
├── full_name (TEXT)
├── email (TEXT)
├── whatsapp (TEXT)
├── status (TEXT: 'pending', 'approved', etc)
├── generated_code (TEXT)
└── created_at (TIMESTAMPTZ)

agents
├── id (UUID)
├── name (TEXT)
├── mobile_number (TEXT)
├── contact (TEXT)
└── created_at (TIMESTAMPTZ)

access_codes
├── id (UUID)
├── code (TEXT UNIQUE)
├── total_seats (INT)
├── used_seats (INT)
├── amount (NUMERIC)
├── agent_name (TEXT)
├── assigned_emails (TEXT[])
├── expires_at (TIMESTAMPTZ)
└── created_at (TIMESTAMPTZ)

profiles
├── id (UUID)
├── email (TEXT)
├── full_name (TEXT)
├── mobile_number (TEXT)
├── access_level (ENUM: 'free' | 'full')
└── created_at (TIMESTAMPTZ)
```

## 🔐 Security Features

All sensitive operations are protected by:
- **RLS (Row-Level Security)**: Database level enforcement
- **SECURITY DEFINER Functions**: Admin operations run with elevated permissions
- **Role-Based Access Control**: Admins have full access, users see only their own data
- **Session Management**: Supabase handles authentication tokens

## 🛠️ Troubleshooting

### "Permission Denied for Function has_role"
- ✅ **FIXED**: The function now has proper GRANT EXECUTE permissions

### Admin Dashboard Not Loading
- Check browser console for errors
- Ensure you've claimed the admin role
- Navigate to `/admin` directly

### Access Requests Not Showing
- ✅ **FIXED**: RLS policies updated to allow admins to see all requests
- Submit a test access request from a non-admin account
- Refresh the admin dashboard

### Users Not Appearing
- ✅ **FIXED**: Profiles table has proper RLS policies
- Admin can view all profiles
- Users see only their own profile

## 📝 Adding More Users Programmatically

To add multiple users via SQL:

```sql
-- Add Polite Tafirenyika
INSERT INTO public.profiles (id, email, full_name, mobile_number, access_level)
VALUES (
  gen_random_uuid(),
  'polite.tafirenyika@example.com',
  'Polite Tafirenyika',
  '',
  'free'
) RETURNING id;

-- Then add user role
INSERT INTO public.user_roles (user_id, role)
VALUES ('<uuid-from-above>', 'user');
```

## 🎯 Application Flow

```
Homepage
├── Not Authenticated
│   ├── Sign In → Create Account → Admin Setup (if first user)
│   ├── Request Access → Submit Form → Appears in Access Requests
│   └── Install App → PWA Installation
│
└── Authenticated
    ├── Admin User
    │   └── /admin → Full Dashboard Access
    │       ├── Access Requests Management
    │       ├── Agents Management
    │       ├── Access Codes Management
    │       ├── Users Management
    │       └── Payment Requests Management
    │
    └── Regular User
        └── Study Topics → Flip Cards → Request Full Access
```

## ✨ Success Indicators

You'll know everything is working when:

1. ✅ You can sign up and claim admin role
2. ✅ You can see "Polite Tafirenyika" in the users list
3. ✅ Access requests appear in the admin dashboard
4. ✅ You can approve access requests and generate codes
5. ✅ No "permission denied" errors appear
6. ✅ All admin features are accessible

---

**Setup Date**: June 9, 2026  
**Project**: Power Study Buddy  
**Status**: Ready for Testing ✅
