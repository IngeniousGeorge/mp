class Product < ApplicationRecord
  belongs_to :seller
  has_many :product_tags
  has_many :product_translations
  accepts_nested_attributes_for :product_tags, allow_destroy: true, reject_if: proc { |attributes| attributes['tag'].blank? }
  accepts_nested_attributes_for :product_translations, allow_destroy: true, reject_if: proc { |attributes| attributes['description'].blank? }
  
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

  def prepare_empty_translations
    I18n.non_default_locales_hash.size.times { self.product_translations.build }
  end
  # I18n.non_default_locales_hash in config/initializers/extensions/i18n.rb

  # translation methods
 

    # def translate_collection(lang, collection)
    #   translated_products = []
    #   collection.each { |product| translated_products << product.translate(lang) }
    #   return translated_products
    # end

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