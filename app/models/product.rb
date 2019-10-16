class Product < ApplicationRecord
  belongs_to :seller
  has_many :product_tags
  has_many :product_translations
  accepts_nested_attributes_for :product_tags, allow_destroy: true, reject_if: proc { |attributes| attributes['tag'].blank? }
  
  has_one_attached :cover
  has_many_attached :images
  validates_with ProductImagesValidator

  extend FriendlyId
  friendly_id :name_and_seller_slug, use: :slugged
  
  def name_and_seller_slug
    "#{name}-#{self.seller.slug}"
  end

  def prepare_empty_tags
    (ProductTag.max_num_of_tags_per_product - self.product_tags.count).times { self.product_tags.build }
  end

  # translation methods
    # def translate(lang)
    #   if translation = self.product_translation(lang)
    #     translated_product = Product.new(self.attributes)
    #     translated_product.name = translation.name
    #     translated_product.description = translation.description
    #     return translated_product
    #   else
    #     self
    #   end
    # end

    # def to
    #   self.class
    # end

    def translate_collection(lang, collection)
      translated_products = []
      collection.each { |product| translated_products << product.translate(lang) }
      return translated_products
    end

    # def product_translation(lang)
    #   self.product_translations.where(lang: lang).take
    # end

  def self.categories
    Category.pluck(:name)
  end

  def self.find_by_tag(tag)
    Product.find_by_sql(["SELECT * FROM products WHERE id IN (SELECT product_id FROM product_tags WHERE tag LIKE ?)", tag])
  end
end