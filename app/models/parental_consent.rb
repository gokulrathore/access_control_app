class ParentalConsent < ApplicationRecord
  belongs_to :account
  validates :parent_email, presence: true
end
