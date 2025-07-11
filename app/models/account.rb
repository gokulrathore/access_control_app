class Account < ApplicationRecord
  has_secure_password
  belongs_to :organization, optional: true
  belongs_to :age_group, optional: true 

  has_one :parental_consent, dependent: :destroy
  has_many :organization_memberships , dependent: :destroy
  has_many :organizations, through: :organization_memberships

  validates :role, inclusion: { in: %w[user minor_user admin] }
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :age, presence: true
  validate :age_matches_age_group

  def age_matches_age_group
    return unless age_group

    unless age.between?(age_group.min_age, age_group.max_age)
      errors.add(:age_group_id, "does not match user's age")
    end
  end
end
