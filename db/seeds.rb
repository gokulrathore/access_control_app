# Clear existing data
puts "⏳ Clearing existing data..."
OrganizationMembership.destroy_all
ParentalConsent.destroy_all
CommunityEvent.destroy_all
Account.destroy_all
Organization.destroy_all
AgeGroup.destroy_all

puts "✅ Starting seeding..."

# 🌱 Age Groups
puts "🌱 Creating age groups..."
child_group = AgeGroup.create!(name: "Child", min_age: 0, max_age: 12)
teen_group  = AgeGroup.create!(name: "Teen",  min_age: 13, max_age: 17)
adult_group = AgeGroup.create!(name: "Adult", min_age: 18, max_age: 100)

# 👑 Platform Admin Account
puts "👑 Creating platform admin account..."

admin_user = Account.create!(
  full_name: "Super Admin",
  email: "admin@example.com",
  password: "admin123",
  age: 30,
  age_group: adult_group,
  role: "admin"
)

# 🏢 Organizations
puts "🏢 Creating organizations..."
org1 = Organization.create!(name: "Youth Club", description: "For young learners", min_age: 10)
org2 = Organization.create!(name: "Tech Society", description: "For teens and adults", min_age: 13)

# 👦 Child User
puts "👶 Creating child account..."

child_user = Account.create!(
  full_name: "Child User",
  email: "child@example.com",
  password: "password",
  age: 10,
  age_group: child_group,
  role: "user",
  organization_id: org1
)

ParentalConsent.create!(
  account: child_user,
  parent_email: "parent@example.com",
  approved: true
)

# 👨 Teen User
puts "🧑 Creating teen account..."

teen_user = Account.create!(
  full_name: "Teen User",
  email: "teen@example.com",
  password: "password",
  age: 15,
  age_group: teen_group,
  role: "minor_user" ,
  organization_id: org2

)

# 👨 Adult User
puts "👨‍💼 Creating adult account..."

adult_user = Account.create!(
  full_name: "Adult User",
  email: "adult@example.com",
  password: "password",
  age: 25,
  age_group: adult_group,
  role: "user",
  organization_id: org2
)

# 🤝 Organization Memberships
puts "🧾 Adding organization memberships..."

OrganizationMembership.create!(account: child_user, organization: org1, role: :member)
OrganizationMembership.create!(account: teen_user,  organization: org1, role: :moderator)
OrganizationMembership.create!(account: adult_user, organization: org2, role: :admin)

# 📅 Community Events
puts "📅 Creating community events..."

CommunityEvent.create!(
  title: "Drawing Contest",
  description: "For kids to showcase their creativity",
  starts_at: 5.days.from_now,
  audience: "Child"
)

CommunityEvent.create!(
  title: "Hackathon",
  description: "Build apps and solve problems",
  starts_at: 10.days.from_now,
  audience: "Teen"
)

CommunityEvent.create!(
  title: "Financial Literacy Workshop",
  description: "For adults to manage finances better",
  starts_at: 7.days.from_now,
  audience: "Adult"
)

CommunityEvent.create!(
  title: "Community Cleanup",
  description: "Open for all age groups",
  starts_at: 3.days.from_now,
  audience: "All"
)

puts "✅ Seeding complete!"
