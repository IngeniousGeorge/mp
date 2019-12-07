class OrderLine < ApplicationRecord
  belongs_to :order
  belongs_to :client
  belongs_to :sale
  belongs_to :seller
  belongs_to :product
end