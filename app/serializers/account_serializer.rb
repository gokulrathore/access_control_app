class AccountSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :age, :role, :organization_id ,:age_group_id
   belongs_to :age_group
end