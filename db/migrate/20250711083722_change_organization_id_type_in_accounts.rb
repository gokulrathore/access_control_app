class ChangeOrganizationIdTypeInAccounts < ActiveRecord::Migration[6.1]
  def change
    # Step 1: Remove the uuid column
    remove_column :accounts, :organization_id, :uuid

    # Step 2: Add the new integer column
    add_column :accounts, :organization_id, :integer
  end
end
