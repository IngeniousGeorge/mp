class Product < ApplicationRecord
  belongs_to :seller
  
  has_one_attached :logo
  has_many_attached :images

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: :seller
end
