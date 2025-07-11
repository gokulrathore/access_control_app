# 🚦 Access Control App

A Ruby on Rails application implementing **custom authentication**, **organization-based access control**, and **age-based participation restrictions** with parental consent workflow.

---

## 🔍 Project Overview

This app solves two main access control problems:

1. **Organization-Based Access Control**
   - Users can join organizations if they meet the minimum age.
   - Each user has a role (`member`, `moderator`, `admin`) in their organization.
   - Organizations have their own participation rules and analytics.

2. **Age-Based Participation Rules**
   - Users are auto-assigned an age group: **Child**, **Teen**, or **Adult**.
   - Children under 13 must provide **parental consent**.
   - Community events are filtered based on age group.

---

## 🔐 Key Features

- ✅ JWT-based login and signup
- ✅ Age group classification: Child (0–12), Teen (13–17), Adult (18+)
- ✅ Parental consent approval by admin
- ✅ Role-based permissions in organizations
- ✅ Event filtering based on age group
- ✅ Organization analytics dashboard

---

## ⚙️ Tech Stack

- **Ruby** 3.x
- **Rails** 8.x
- **PostgreSQL** (or SQLite for dev)
- **JWT** for authentication

---

## 🚀 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/your-username/access_control_app.git
cd access_control_app
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Set up the database

```bash
rails db:create
rails db:migrate
rails db:seed
```

✅ The seed file creates:
- 3 age groups (Child, Teen, Adult)
- 2 organizations with min age requirements
- A platform **Admin** account
- A **Child** user with parental consent required
- A **Teen** and **Adult** user
- 4 sample community events (filtered by age group)

### 4. Start the Rails server

```bash
rails server
```

Visit: [http://localhost:3000](http://localhost:3000)

---

## 👤 Sample User Accounts

| Role        | Email              | Password     |
|-------------|--------------------|--------------|
| Admin       | admin@example.com  | admin123     |
| Child       | child@example.com  | password     |
| Teen        | teen@example.com   | password     |
| Adult       | adult@example.com  | password     |

---

## 🔑 API Overview

### Auth
- `POST /signup` → Create account (auto-assign age group & role)
- `POST /login` → Return JWT token

### Community Events
- `GET /community_events` → List of events filtered by user's age group
- `GET /community_events/:id` → Event detail

### Organizations
- `GET /organizations` → List organizations
- `GET /organizations/:id/analytics` → Organization analytics (admin only)

### Parental Consent
- `POST /parental_consents/:id/approve` → Approve child account (admin only)

---

## 📊 Organization Analytics

Available at:
```http
GET /organizations/:id/analytics
```

Includes:
- Total members
- Role breakdown
- Age group distribution
- Recent signups by date

---

## 🎥 Demo Video Highlights

Your demo should show:

1. **Signup Flow**
   - Child (requires parental consent)
   - Teen and Adult
2. **Parental Consent Approval**
   - Admin approves child user
3. **Organization Join Rules**
   - User rejected if below min age
   - Membership + role creation
4. **Event Filtering**
   - Child sees child events
   - Teen sees teen + all
   - Adult sees adult + all
5. **Organization Analytics**
   - Role count, age group distribution, signups by day

---

## 🗂️ Project Structure

| Path           | Description                           |
|----------------|---------------------------------------|
| `app/models`   | Business logic (Account, Org, etc.)   |
| `app/controllers` | All API logic                     |
| `db/seeds.rb`  | Sample data with 3 users and events   |
| `config/routes.rb` | Routes for APIs                  |
| `app/serializers` | Controls API JSON structure       |

---

## 🧪 Run Tests (optional)

```bash
bundle exec rspec
```

---

## 🙋 Contributing

Contributions are welcome! Please open an issue or submit a pull request.

---

## 📄 License

MIT License

---

## ✅ Status

✅ Fully functional for demo and basic production  
🔒 Authentication and access rules enforced  
📊 Analytics & filtering features ready

---

## 📬 Contact

Built by **Gokul Rathore**  
📧 Email: gokul@example.com  
🌐 GitHub: [github.com/gokulrathore](https://github.com/gokulrathore)
