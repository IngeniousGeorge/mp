class Basket < ApplicationRecord
  belongs_to :client, required: false
  has_many :basket_lines

  def lines
    BasketLine.where(basket_id: self.id)
  end

    public
    
    # called from devise after login
    def overwrite_lines(other_basket)
      other_basket.basket_lines.each do |line|
        line.basket_id = self.id
        line.save
      end
    end

end