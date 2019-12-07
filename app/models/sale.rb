class Sale < ApplicationRecord
  belongs_to :order
  belongs_to :client
  belongs_to :seller
  has_many :oder_lines

end