class CreateCommunityEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :community_events do |t|
      t.string :title
      t.text :description
      t.string :audience
      t.datetime :starts_at

      t.timestamps
    end
  end
end
