class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :description
      t.integer :min_age

      t.timestamps
    end
  end
end
