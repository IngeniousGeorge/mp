class Basket < ApplicationRecord
  belongs_to :client, required: false

    public

    def merge_basket_products!(other_basket)
      self.products.merge!(other_basket.products){|key, oldval, newval| newval + oldval}
    end
end
