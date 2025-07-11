class Organization < ApplicationRecord
  has_many :accounts , dependent: :destroy
  has_many :organization_analytics , dependent: :destroy
  has_many :organization_memberships , dependent: :destroy
  has_many :accounts, through: :organization_memberships

end
