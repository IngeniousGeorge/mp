class Basket < ApplicationRecord
  belongs_to :client, required: false
  has_many :basket_lines

  def lines
    basket_lines
  end

    public
    
    # called from devise after login
    def duplicate_lines(other_basket)
      other_basket.basket_lines.each do |line|
        BasketLine.create(product_id: line.product_id, quantity: line.quantity, basket_id: self.id)
        # line.basket_id = self.id
        # line.save
      end
    end

end