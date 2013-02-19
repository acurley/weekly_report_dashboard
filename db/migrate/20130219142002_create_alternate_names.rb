class CreateAlternateNames < ActiveRecord::Migration
  def change
    create_table :alternate_names do |t|
      t.integer :property_id
      t.string :name

      t.timestamps
    end
  end
end
