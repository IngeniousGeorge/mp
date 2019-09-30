class Basket < ApplicationRecord
  belongs_to :client, required: false
  has_many :basket_lines

    public

    def merge_basket_products!(other_basket)
      self.products.merge!(other_basket.products){|key, oldval, newval| newval + oldval}
    end

    def change_product(id, quantity)
      
    end

end