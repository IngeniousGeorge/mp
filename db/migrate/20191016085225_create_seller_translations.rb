class CreateSellerTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :seller_translations do |t|
      t.string :lang
      t.text :description
      t.uuid :seller_id

      t.timestamps
    end
  end
end
