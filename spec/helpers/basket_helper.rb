require "helpers/client_helper"
require "helpers/product_helper"

def add_product_to_basket
  visit catalogue_path
  within("form[action='/en/basket_lines']") do
    click_button "Add to basket"
  end
end

def last_created_basket
  Basket.order("created_at").last
end

def last_created_basket_line
  BasketLine.order("created_at").last
end