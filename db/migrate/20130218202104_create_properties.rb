class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :total_units
      t.integer :phases

      t.timestamps
    end
  end
end
