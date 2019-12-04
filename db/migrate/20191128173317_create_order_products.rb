class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :product_id
      t.integer :quantity
      t.integer :amount
      t.uuid :order_sale_id
      t.uuid :order_id
    end
  end
end
