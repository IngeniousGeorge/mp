class CreateProductTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :product_translations do |t|
      t.string :lang
      t.string :name
      t.text :description
      t.uuid :product_id

      t.timestamps
    end
  end
end
