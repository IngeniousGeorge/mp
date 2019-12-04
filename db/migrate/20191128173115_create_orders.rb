class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :client_id
      t.integer :amount
    end
  end
end
