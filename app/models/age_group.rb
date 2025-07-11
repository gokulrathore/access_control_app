class AgeGroup < ApplicationRecord
 has_many :accounts ,dependent: :destroy
 validates :min_age, :max_age, :name, presence: true
end
