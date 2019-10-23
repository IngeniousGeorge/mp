class Category < ApplicationRecord
  has_many :category_translations, dependent: :destroy
  accepts_nested_attributes_for :category_translations, allow_destroy: true

  after_save :save_categories_in_hash

  def save_categories_in_hash
    require 'categorize'
    Categorize.define_all_as_hash
  end

  def self.for_seller(seller_id)
    Category.find_by_sql(["SELECT name FROM categories WHERE name IN (SELECT category FROM products WHERE seller_id = ?)", seller_id]).pluck(:name)
  end
end