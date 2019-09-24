class Seller < ApplicationRecord
  has_many :locations, as: :owner
  has_many :products
  validates :name, uniqueness: true

  has_one_attached :logo
  has_one_attached :bg
  has_many_attached :images

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :lockable, :timeoutable, :trackable, :validatable#, :confirmable

  extend FriendlyId
  friendly_id :name, use: :slugged
end
