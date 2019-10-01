class Basket < ApplicationRecord
  belongs_to :client, required: false
  has_many :basket_lines

    public

    def merge_baskets(other_basket)
      other_basket.basket_lines.each do |line|
        line.basket_id = self.id
        line.save
      end
    end

end