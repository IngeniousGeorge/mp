class CreateOrderLines < ActiveRecord::Migration[5.2]
  def change
    create_table :order_lines, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :order_id
      t.uuid :sale_id
      t.uuid :client_id
      t.uuid :seller_id
      t.uuid :product_id
      t.integer :quantity
      t.integer :amount
    end
  end
end
