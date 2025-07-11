class CreateOrganizationAnalytics < ActiveRecord::Migration[8.0]
  def change
    create_table :organization_analytics do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :metric
      t.integer :value
      t.datetime :recorded_at

      t.timestamps
    end
  end
end
