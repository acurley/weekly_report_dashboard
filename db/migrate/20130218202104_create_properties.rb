class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :total_units, :default => 0
      t.integer :phases, :default => 1

      t.timestamps
    end
  end
end
