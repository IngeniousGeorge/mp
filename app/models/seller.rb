class Seller < ApplicationRecord
  has_many :products
  has_many :seller_locations
  validates :name, uniqueness: true

  has_one_attached :main_image
  has_many_attached :images

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :lockable, :timeoutable, :trackable, :validatable#, :confirmable

  extend FriendlyId
  friendly_id :name, use: :slugged
end
