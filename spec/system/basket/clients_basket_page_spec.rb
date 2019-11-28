require "rails_helper"
require "helpers/basket_helper"

RSpec.describe "Client -", type: :feature do

  it "can access basket page without an account" do
    product = create_valid_product
    add_product_to_basket
    basket = Basket.take
    visit basket_path("en", basket)
    # save_and_open_page

    expect(page).to have_text(product.name)
  end

  xit "can access basket page through dashboard" do

  end

  it "can pay for all items in basket from basket page" do
    product = create_valid_product
    add_product_to_basket
    basket = Basket.take
    visit basket_path("en", basket)

    expect(page).to have_text("Place Order")  
  end
end