class CreateParentalConsents < ActiveRecord::Migration[8.0]
  def change
    create_table :parental_consents do |t|
      t.references :account, null: false, foreign_key: true
      t.string :parent_email
      t.boolean :approved

      t.timestamps
    end
  end
end
