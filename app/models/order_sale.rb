class OrderSale < ApplicationRecord
  belongs_to :order
  belongs_to :seller

end