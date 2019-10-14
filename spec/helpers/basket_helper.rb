require "helpers/client_helper"
require "helpers/product_helper"

def add_product_to_basket
  visit catalogue_path
  within("form[action='/en/basket_lines']") do
    click_button
  end
end

def add_specific_value_to_basket(value)
  visit catalogue_path
  within("form[action='/en/basket_lines']") do
    fill_in "basket_line_quantity", with: value
    click_button
  end
end

def edit_dashboard_basket_line(client, value)
  visit client_dashboard_path("en", client)
  within(:xpath, "//form[2]") do
    fill_in "basket_line_quantity", with: value
    click_button "Edit"
  end
end

def remove_dashboard_basket_line(client)
  visit client_dashboard_path("en", client)
  within(:xpath, "//form[2]") do
    click_button "Remove"
  end
end

def last_created_basket
  Basket.order("created_at").last
end

def last_created_basket_line
  BasketLine.order("created_at").last
end