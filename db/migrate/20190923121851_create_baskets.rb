class CreateBaskets < ActiveRecord::Migration[5.2]
  def change
    create_table :baskets, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :client_id

      t.timestamps
    end
  end
end
