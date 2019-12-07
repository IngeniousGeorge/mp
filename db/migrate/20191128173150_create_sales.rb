class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :seller_id
      t.uuid :client_id
      t.uuid :order_id
      t.text :order_lines, array: true, default: []
      t.integer :amount

      t.timestamps
    end
  end
end
