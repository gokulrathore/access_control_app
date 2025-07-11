class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password_digest
      t.string :full_name
      t.integer :age
      t.uuid :organization_id
      t.string :role

      t.timestamps
    end
  end
end
