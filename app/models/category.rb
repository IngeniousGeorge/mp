class Category < ApplicationRecord

  def self.all_names
    Category.all.pluck(:name)
  end

  def self.for_seller(seller_id)
    Category.find_by_sql(["SELECT name FROM categories WHERE name IN (SELECT category FROM products WHERE seller_id = ?)", seller_id]).pluck(:name)
  end
end
