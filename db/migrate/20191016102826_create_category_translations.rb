class CreateCategoryTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :category_translations, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :lang
      t.string :name
      t.text :description
      t.uuid :category_id

      t.timestamps
    end
  end
end
