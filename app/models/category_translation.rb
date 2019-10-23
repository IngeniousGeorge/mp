class CategoryTranslation < ApplicationRecord
  belongs_to :category

  after_save :save_categories_in_hash

  def save_categories_in_hash
    require 'categorize'
    Categorize.define_all_as_hash
  end
end