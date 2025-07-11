class AddAgeGroupToAccounts < ActiveRecord::Migration[8.0]
  def change
    add_reference :accounts, :age_group
  end
end
