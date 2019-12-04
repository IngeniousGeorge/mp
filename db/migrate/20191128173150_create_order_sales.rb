class CreateOrderSales < ActiveRecord::Migration[5.2]
  def change
    create_table :order_sales, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :seller_id
      t.integer :amount
      t.uuid :order_id
    end
  end
end
