class ProductTag < ApplicationRecord
  belongs_to :product
  validates_uniqueness_of :tag, scope: :product_id, case_sensitive: false
  
  def self.max_num_of_tags_per_product
    5    
  end
end
