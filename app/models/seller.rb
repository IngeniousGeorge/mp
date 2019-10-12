class Seller < ApplicationRecord
  has_many :locations, as: :owner
  has_many :products
  validates :name, uniqueness: true

  has_one_attached :cover
  has_many_attached :images

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :lockable, :timeoutable, :trackable, :validatable#, :confirmable

  extend FriendlyId
  friendly_id :name, use: :slugged

  def categories
    Category.for_seller(self.id)
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