class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :property_id
      t.date :date_retrieved
      t.integer :current_occupied
      t.integer :total_vacants
      t.integer :vacant_rented
      t.integer :vacant_unrented
      t.float :percent_occupied
      t.float :percent_preleased
      t.integer :total_guest_cards
      t.integer :total_apps

      t.timestamps
    end
  end
end
