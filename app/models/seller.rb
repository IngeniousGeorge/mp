class Seller < ApplicationRecord
  has_many :locations, as: :owner
  has_many :products
  validates :name, uniqueness: true

  has_one_attached :cover
  has_one_attached :bg
  has_many_attached :images

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :lockable, :timeoutable, :trackable, :validatable#, :confirmable

  extend FriendlyId
  friendly_id :name, use: :slugged

  def categories
    Category.find_by_sql(["SELECT name FROM categories WHERE name IN (SELECT category FROM products WHERE seller_id = ?)", self.id]).pluck(:name)
  end
end
