class CreateProductTags < ActiveRecord::Migration[5.2]
  def change
    create_table :product_tags, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :lang
      t.string :tag
      t.uuid :product_id

      t.timestamps
    end
    add_index :product_tags, :tag, name: "index_product_tags_on_tag"
  end
end
