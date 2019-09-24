class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name
      t.string :recipient
      t.text :street
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.float :latitude
      t.float :longitude
      t.uuid :owner_id
      t.string :owner_type

      t.timestamps
    end
    add_index :locations, [:owner_type, :owner_id], name: "index_locations_on_owner"
    add_index :locations, [:latitude, :longitude], name: "index_locations_on_latitude_and_longitude"
  end
end
