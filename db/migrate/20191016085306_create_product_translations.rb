class CreateProductTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :product_translations, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :lang
      t.text :description
      t.uuid :product_id

      t.timestamps
    end
  end
end
