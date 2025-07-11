class OrganizationMembership < ApplicationRecord
  belongs_to :account
  belongs_to :organization
  validates :role, inclusion: { in: %w[member moderator admin] }
end
