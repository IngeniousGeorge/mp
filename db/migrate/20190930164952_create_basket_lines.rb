class CreateBasketLines < ActiveRecord::Migration[5.2]
  def change
    create_table :basket_lines, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :basket_id
      t.uuid :product_id
      t.integer :quantity

      t.timestamps
    end
  end
end
