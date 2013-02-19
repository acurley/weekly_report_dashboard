class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :property_id
      t.date :date_retrieved
      t.integer :current_occupied, :default => 0
      t.integer :total_vacants, :default => 0
      t.integer :vacant_rented, :default => 0
      t.integer :vacant_unrented, :default => 0
      t.float :percent_occupied, :default => 0.0
      t.float :percent_preleased, :default => 0.0
      t.integer :total_guest_cards, :default => 0
      t.integer :total_apps, :default => 0

      t.timestamps
    end
  end
end
