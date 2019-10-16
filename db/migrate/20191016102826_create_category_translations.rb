class CreateCategoryTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :category_translations do |t|
      t.string :lang
      t.text :name
      t.integer :category_id

      t.timestamps
    end
  end
end
