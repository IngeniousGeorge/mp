class Product < ApplicationRecord
  belongs_to :seller
  
  has_one_attached :main_image
  has_many_attached :images

  # use slug candidates!
  extend FriendlyId
  friendly_id :name, use: :slugged
end
