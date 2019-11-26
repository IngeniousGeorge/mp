class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.uuid :category, null: false
      t.text :description
      t.text :tags, array: true, default: []
      t.integer :price, null: false
      t.integer :price_excl_vat, null: false
      t.integer :price_discount
      t.integer :price_discount_excl_vat
      t.string :translations, default: "en"
      t.uuid :seller_id, null: false

      t.timestamps
    end

    add_index :products, :slug, unique: true
    add_index :products, :category, name: "index_products_on_category"
    add_index :products, :seller_id, name: "index_products_on_seller_id"
  end
end
