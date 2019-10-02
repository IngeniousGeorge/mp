class Product < ApplicationRecord
  belongs_to :seller
  has_many :product_tags
  accepts_nested_attributes_for :product_tags, allow_destroy: true, reject_if: proc { |attributes| attributes['tag'].blank? }
  
  has_one_attached :logo
  has_many_attached :images

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: :seller

  def prepare_empty_tags
    (ProductTag.max_num_of_tags_per_product - self.product_tags.count).times { self.product_tags.build }
  end

  def tags
    tags = []
    self.product_tags.each { |t| tags << t.tag }
    tags
  end
end
