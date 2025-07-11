# app/policies/account_policy.rb
class AccountPolicy < ApplicationPolicy
  def access_organization_portal?
    user.organization_id == record.organization_id && user.role == 'admin'
  end
end
