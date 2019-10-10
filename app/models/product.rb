class Product < ApplicationRecord
  belongs_to :seller
  has_many :product_tags
  accepts_nested_attributes_for :product_tags, allow_destroy: true, reject_if: proc { |attributes| attributes['tag'].blank? }
  
  has_one_attached :logo
  has_many_attached :images
  validates_with ProductImagesValidator

  extend FriendlyId
  # friendly_id :name, use: :scoped, scope: :seller
  friendly_id :name_and_seller_slug, use: :slugged
  
  def name_and_seller_slug
    "#{name}-#{self.seller.slug}"
  end

  def prepare_empty_tags
    (ProductTag.max_num_of_tags_per_product - self.product_tags.count).times { self.product_tags.build }
  end

  def self.categories
    Category.pluck(:name)
  end
end