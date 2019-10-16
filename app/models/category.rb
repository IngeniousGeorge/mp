class Category < ApplicationRecord
  has_many :category_translations

  after_save :save_categories_in_arrays

  def save_categories_in_arrays
    names = Category.all.pluck(:name)
    Category.define_method(:all_names) { names } #define_singleton_method?

    # do it for all languages
  end
  
  # def self.all_names
  #   Category.all.pluck(:name)
  # end

  def self.for_seller(seller_id)
    Category.find_by_sql(["SELECT name FROM categories WHERE name IN (SELECT category FROM products WHERE seller_id = ?)", seller_id]).pluck(:name)
  end

end