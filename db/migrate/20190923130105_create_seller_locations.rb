class CreateSellerLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :seller_locations, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :location_id
      t.uuid :seller_id

      t.timestamps
    end
  end
end
