require "rails_helper"
require "helpers/basket_helper"

RSpec.describe "Order -", type: :feature do

  it "gets created when client places order" do
    product = create_valid_product
    add_product_to_basket
    basket = Basket.take
    visit basket_path("en", basket)
    click_link("Place Order")

    expect(page).to have_text("Order was successfully registered")
  end

  it "also creates sales object for every seller present in order" do

  end

end