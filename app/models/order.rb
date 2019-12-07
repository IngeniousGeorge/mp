class Order < ApplicationRecord
  belongs_to :client
  has_many :order_sales
  has_many :order_products

  before_save :order_management

  def order_management
    if self.create_sales && self.create_products && self.purge_basket
      true
    else
      false
    end
  end

  def create_sales
    p "cs"
    OrderSale.new(order_id: self.id, seller_id: Seller.take.id).save
    true
  end

  def create_products
    p "cp"
    true
  end

  def purge_basket
    p "pb"
    false
  end
end