class CreateClientLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :client_locations, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :location_id
      t.uuid :client_id

      t.timestamps
    end
  end
end
