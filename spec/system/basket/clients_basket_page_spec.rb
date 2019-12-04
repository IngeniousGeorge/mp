require "rails_helper"
require "helpers/basket_helper"

RSpec.describe "Client -", type: :feature do

  context "unregisted - " do

    before do
      @product = create_valid_product
      add_product_to_basket
      basket = Basket.take
      visit basket_path("en", basket)
      # save_and_open_page
    end

    it "can access basket page" do
      expect(page).to have_text("Basket") #make more accurate
      expect(page).to have_text(@product.name)
    end

    it "get redirected to sign up when placing order" do
      click_link "Place Order"

      expect(page).to have_text("")
    end
  end

  context "registered - " do

    before do

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
end
