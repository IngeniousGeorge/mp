class CreateSellerTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :seller_translations, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :lang
      t.string :name
      t.string :slug
      t.text :description
      t.uuid :seller_id

      t.timestamps
    end
  end
end
