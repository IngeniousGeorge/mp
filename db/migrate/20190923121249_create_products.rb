class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :category, null: false
      t.text :key_words
      t.text :description
      t.integer :price, null: false
      t.integer :price_excl_vat, null: false
      t.integer :price_discount
      t.uuid :seller_id, null: false

      t.timestamps
    end

    add_index :products, :slug, unique: true
  end
end
