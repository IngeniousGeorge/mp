require "rails_helper"
require "helpers/basket_helper"

RSpec.describe "Order -", type: :feature do

  context "Client places order - " do

    before do
      # create client
      sign_up_client
      # create sellers and products
      @seller_1 = create(:seller, name: "seller 1")
      @prod_1 = create_valid_product({name: "product 1"}, @seller_1)
      @seller_2 = create(:seller, name: "seller 2", email: "seller2@email.com")
      @prod_2 = create_valid_product({name: "product 2"}, @seller_2)
      # add products to basket
      visit catalogue_path
      find(:xpath, "(//form[@action='/en/basket_lines'])[1]").find('input[value="add"]').click
      find(:xpath, "(//form[@action='/en/basket_lines'])[1]").find('input[value="add"]').click
      find(:xpath, "(//form[@action='/en/basket_lines'])[2]").find('input[value="add"]').click
      # place order
      visit basket_path("en", Basket.take)
      click_link "Place Order"
    end

    it "saves an order" do

    end

    # it "saves order lines" do

    # end

    # it "saves sales" do

    # end

  end
  # it "gets created when client places order" do
  #   product = create_valid_product
  #   add_product_to_basket
  #   basket = Basket.take
  #   visit basket_path("en", basket)
  #   click_link("Place Order")

  #   expect(page).to have_text("Order was successfully registered")
  # end

  # it "also creates sales object for every seller present in order" do

  # end

end