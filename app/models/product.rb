class Product < ApplicationRecord
  belongs_to :seller
  
  has_one_attached :logo
  has_many_attached :images

  # use slug candidates!
  extend FriendlyId
  friendly_id :name, use: :slugged
end
