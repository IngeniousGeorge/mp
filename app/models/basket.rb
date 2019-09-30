class Basket < ApplicationRecord
  belongs_to :client, required: false

    public

    def merge_basket_products!(other_basket)
      self.products.merge!(other_basket.products){|key, oldval, newval| newval + oldval}
    end

    # def change_product(data)
    #   p self.products.class
    #   p data
    #   p data.to_h
    #   p data.class
    #   self.products.as_json.merge!(data.as_json){|key, oldval, newval| newval + oldval}
    # end
end
