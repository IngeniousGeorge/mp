class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.text :street
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.float :lat
      t.float :lon

      t.timestamps
    end
    add_index :locations, :lat, name: "index_locations_on_lat"
    add_index :locations, :lon, name: "index_locations_on_lon"
  end
end
