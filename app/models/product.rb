class Product < ApplicationRecord
  belongs_to :seller

  after_save :save_tags
  
  has_one_attached :logo
  has_many_attached :images

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: :seller

  def save_tags
    p "called now"
    raise "error"
  end
end
