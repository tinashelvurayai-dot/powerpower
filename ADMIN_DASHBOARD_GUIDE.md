# Admin Dashboard Code Reference

## Admin Dashboard Location
- **Route**: `/admin`
- **File**: `/src/routes/admin.tsx`
- **Access**: Admin users only (redirects to `/admin-setup` if not authenticated)

## Admin Panel Tabs

### 1. Access Requests Panel

**Purpose**: Manage user access requests from agents

**Code Reference**:
```typescript
function RequestsPanel() {
  const [rows, setRows] = useState<any[]>([]);
  const [filter, setFilter] = useState<"pending" | "all">("all");
  
  const load = async () => {
    let q = supabase
      .from("access_requests")
      .select("*")
      .order("created_at", { ascending: false });
    
    if (filter === "pending") 
      q = q.eq("status", "pending");
    
    const { data, error } = await q;
    setRows(data || []);
  };
  
  const approve = async (id: string) => {
    const res = await accessApi.approve({ request_id: id });
    toast.success(`Approved. Code ${res.code} — copied.`);
    load();
  };
  
  const reject = async (id: string) => {
    await accessApi.reject({ request_id: id });
    toast.success("Rejected");
    load();
  };
}
```

**Features**:
- ✅ View pending/all requests
- ✅ Auto-refresh every 8 seconds
- ✅ Approve with one-click code generation
- ✅ Reject requests
- ✅ Send code via Gmail or WhatsApp
- ✅ Copy code to clipboard
- ✅ Delete requests
- ✅ See request counts (pending, approved, total)

**Data Shown**:
```javascript
{
  id: string;
  full_name: string;
  whatsapp: string;
  email: string;
  status: "pending" | "approved" | "rejected";
  created_at: timestamp;
  generated_code: string; // after approval
  synthetic_email: string; // after approval
}
```

### 2. Access Codes Panel

**Purpose**: Generate and manage access codes

**Code Reference**:
```typescript
function CodesPanel() {
  const [codes, setCodes] = useState<any[]>([]);
  const [seats, setSeats] = useState(1);
  const [amount, setAmount] = useState(5);
  const [agent, setAgent] = useState("");
  const [assigned, setAssigned] = useState("");
  
  const generate = async () => {
    const assignedList = assigned
      .split(",")
      .map(s => s.trim().toLowerCase())
      .filter(Boolean);
    
    const rows = Array.from({ length: bulk }, () => ({
      code: randCode(),
      total_seats: seats,
      amount,
      agent_name: agent || null,
      assigned_emails: assignedList,
    }));
    
    await supabase.from("access_codes").insert(rows);
    toast.success(`Generated ${rows.length} codes`);
    load();
  };
  
  const exportCsv = () => {
    // Export codes as CSV file
  };
}
```

**Features**:
- ✅ Generate single or bulk codes
- ✅ Set seats per code
- ✅ Set amount/price
- ✅ Assign to specific agents
- ✅ Assign to specific emails
- ✅ Search codes
- ✅ Export to CSV
- ✅ Copy code to clipboard
- ✅ Delete codes
- ✅ Track usage (used_seats / total_seats)

**Data Shown**:
```javascript
{
  id: string;
  code: string; // e.g., "AUT-ABC1-DEF2"
  total_seats: number;
  used_seats: number;
  amount: number;
  agent_name: string;
  assigned_emails: string[];
  created_at: timestamp;
  expires_at: timestamp | null;
}
```

### 3. Users Panel

**Purpose**: Manage user accounts

**Code Reference**:
```typescript
function UsersPanel() {
  const [profiles, setProfiles] = useState<any[]>([]);
  
  const loadProfiles = async () => {
    const { data } = await supabase
      .from("profiles")
      .select("*, user_roles!inner(role)")
      .order("created_at", { ascending: false });
    setProfiles(data || []);
  };
  
  const createUser = async () => {
    const res = await accessApi.createUser({
      email: userEmail,
      password: userPassword,
      full_name: userName,
      access_level: accessLevel,
    });
    toast.success("User created");
    loadProfiles();
  };
}
```

**Features**:
- ✅ View all user profiles
- ✅ Create new users
- ✅ Set access level (free/full)
- ✅ View user roles (admin/user)
- ✅ Deactivate users
- ✅ Reset password
- ✅ Search users

**Data Shown**:
```javascript
{
  id: string;
  email: string;
  full_name: string;
  mobile_number: string;
  access_level: "free" | "full";
  created_at: timestamp;
  user_roles: [{
    role: "admin" | "user"
  }];
}
```

### 4. Agents Panel

**Purpose**: Manage agents

**Code Reference**:
```typescript
function AgentsPanel() {
  const [agents, setAgents] = useState<any[]>([]);
  
  const addAgent = async () => {
    const { error } = await supabase
      .from("agents")
      .insert({
        name: agentName,
        mobile_number: mobileNumber,
        contact: contactInfo,
      });
    
    if (error) {
      toast.error(error.message);
      return;
    }
    toast.success("Agent added");
    loadAgents();
  };
}
```

**Features**:
- ✅ Add new agents
- ✅ View agent details
- ✅ Edit agent info
- ✅ Delete agents
- ✅ Track codes by agent
- ✅ See commission/payments

**Data Shown**:
```javascript
{
  id: string;
  name: string;
  mobile_number: string;
  contact: string;
  created_at: timestamp;
}
```

### 5. Payments Tab

**Purpose**: Track and manage payment requests

**Features**:
- ✅ View payment requests
- ✅ Update payment status
- ✅ Generate payment codes
- ✅ Track student emails
- ✅ Add notes/comments

**Data Shown**:
```javascript
{
  id: string;
  agent_name: string;
  student_email: string;
  student_email_2: string;
  amount: number;
  status: "pending" | "approved" | "rejected";
  generated_code: string;
  notes: string;
  created_at: timestamp;
}
```

### 6. Support Tickets Tab

**Purpose**: Manage user support requests

**Features**:
- ✅ View all support tickets
- ✅ Mark as in_progress
- ✅ Close tickets
- ✅ Reply to users
- ✅ Track ticket history

**Data Shown**:
```javascript
{
  id: string;
  user_id: string;
  user_email: string;
  subject: string;
  message: string;
  status: "open" | "in_progress" | "closed";
  created_at: timestamp;
}
```

### 7. Content Tab

**Purpose**: Manage flashcards and topic sets

**Features**:
- ✅ Create topic sets
- ✅ Add flashcards
- ✅ Set free card limits
- ✅ Organize by order
- ✅ Edit/delete cards

**Data Shown**:
```javascript
// Topic Sets
{
  id: string;
  title: string;
  description: string;
  order_index: number;
  free_card_limit: number;
  created_at: timestamp;
}

// Cards
{
  id: string;
  topic_set_id: string;
  question: string;
  answer: string;
  order_index: number;
  created_at: timestamp;
}
```

## Database Schema Details

### Profiles Table
```sql
CREATE TABLE profiles (
  id UUID PRIMARY KEY,
  email TEXT NOT NULL,
  full_name TEXT,
  mobile_number TEXT,
  access_level access_level ('free' | 'full'),
  created_at TIMESTAMPTZ
);
```

### User Roles Table
```sql
CREATE TABLE user_roles (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES auth.users,
  role app_role ('admin' | 'user'),
  UNIQUE(user_id, role)
);
```

### Access Requests Table
```sql
CREATE TABLE access_requests (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES auth.users,
  user_email TEXT,
  full_name TEXT,
  whatsapp TEXT,
  email TEXT,
  status TEXT DEFAULT 'pending',
  generated_code TEXT,
  synthetic_email TEXT,
  auto_password TEXT,
  approved_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ
);
```

### Access Codes Table
```sql
CREATE TABLE access_codes (
  id UUID PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  total_seats INT,
  used_seats INT,
  amount NUMERIC(10,2),
  agent_name TEXT,
  assigned_emails TEXT[],
  bound_user_id UUID,
  expires_at TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ
);
```

### Agents Table
```sql
CREATE TABLE agents (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  mobile_number TEXT,
  contact TEXT,
  created_at TIMESTAMPTZ
);
```

## Key Functions

### Admin Verification
```typescript
// Middleware to check if user is admin
const { user, isAdmin } = useAuth();

if (!isAdmin) {
  nav({ to: "/dashboard" }); // redirect non-admins
}
```

### Generate Access Code
```typescript
function randCode() {
  const seg = () => Math.random().toString(36).slice(2, 6).toUpperCase();
  return `AUT-${seg()}-${seg()}`; // e.g., "AUT-ABC1-DEF2"
}
```

### API Calls
```typescript
// Submit access request
await accessApi.submit({
  full_name: "Polite Tafirenyika",
  whatsapp: "+263..."
});

// Approve request
const { code } = await accessApi.approve({
  request_id: "..."
});

// Create user (admin only)
await accessApi.createUser({
  email: "polite.tafirenyika@example.com",
  password: "...",
  full_name: "Polite Tafirenyika",
  access_level: "free"
});
```

## Navigation

```
/admin-setup        → First-time admin setup
/admin              → Main admin dashboard
  ├── /admin?tab=requests   → Access requests
  ├── /admin?tab=codes      → Access codes
  ├── /admin?tab=users      → User management
  ├── /admin?tab=agents     → Agent management
  ├── /admin?tab=payments   → Payment tracking
  ├── /admin?tab=tickets    → Support tickets
  └── /admin?tab=content    → Flashcard content
```

## Display in Dashboard

All admin functions show their respective code in the code blocks above. When you:

1. **Approve an access request** → Code displays in the dashboard
2. **Generate codes** → List shows all codes with usage stats
3. **Create users** → Users list updates immediately
4. **Add agents** → Agent list shows new entries
5. **Track payments** → Payment tab shows all transactions
6. **Manage support** → Tickets display with status updates

The dashboard auto-refreshes and shows all changes in real-time!
