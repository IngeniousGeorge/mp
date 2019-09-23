class CreateDbTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :db_translations, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :parent_class
      t.uuid :parent_id
      t.string :parent_atr
      t.string :lang
      t.text :translation

      t.timestamps
    end
  end
end
