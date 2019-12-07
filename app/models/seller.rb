class Seller < ApplicationRecord
  has_many :locations, as: :owner, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :seller_translations, dependent: :destroy
  has_many :sales
  has_many :order_lines
  validates :name, uniqueness: true
  accepts_nested_attributes_for :seller_translations, allow_destroy: true, reject_if: proc { |attributes| attributes['description'].blank? }

  has_one_attached :cover, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :lockable, :timeoutable, :trackable, :validatable#, :confirmable

  extend FriendlyId
  friendly_id :name, use: :slugged

  def categories
    Category.for_seller(self.id)
  end

  def available_translations
    result = {}
    I18n.available_locales.each do |lang|
      result[lang] = self.translations.include? lang.to_s
    end
    return result
  end

  def set_cover_placeholder
    path = Rails.root.join('app', 'assets', 'images', 'placeholders', 'seller-cover.png').to_s
    self.cover.attach(io: File.open(path), filename: 'seller-cover.png')
  end

  def set_images_placeholder
    path = Rails.root.join('app', 'assets', 'images', 'placeholders', 'seller-image.png').to_s
    self.images.attach(io: File.open(path), filename: 'seller-image.png')
  end
end