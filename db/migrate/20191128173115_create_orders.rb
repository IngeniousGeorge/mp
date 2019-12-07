class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :client_id
      t.text :order_lines, array: true, default: []
      t.integer :amount

      t.timestamps
    end
  end
end
