require "rails_helper"
require "helpers/basket_helper"

RSpec.describe "Order -", type: :feature do

  context "Client places order - " do

    before do
      # create client
      sign_up_client
      # create sellers and products
      @seller_1 = create(:seller, name: "seller 1")
      @prod_1 = create_valid_product({name: "product 1", price: 1}, @seller_1)
      @seller_2 = create(:seller, name: "seller 2", email: "seller2@email.com")
      @prod_2 = create_valid_product({name: "product 2", price: 10}, @seller_2)
      # add 3 products to basket
      visit catalogue_path
      find(:xpath, "(//form[@action='/en/basket_lines'])[1]").find('input[value="add"]').click
      find(:xpath, "(//form[@action='/en/basket_lines'])[1]").find('input[value="add"]').click
      find(:xpath, "(//form[@action='/en/basket_lines'])[2]").find('input[value="add"]').click
      # place order
      visit basket_path("en", Basket.take)
      click_link "Place Order"
    end

    it "saves an order" do
      expect(Order.all.size).to eq(1)
      expect(Order.take.amount).to eq(12)
      expect(Order.take.client_id).to eq(Client.take.id)
    end

    it "saves order lines" do
      expect(Order.take.order_lines.size).to eq(2)
      expect(OrderLine.all.size).to eq(2)
    end

    it "saves sales" do
      expect(Sale.all.size).to eq(2)
      expect(Seller.take.sales.size).to eq(1)
      expect(OrderLine.take.sale.client_id).to eq(Client.take.id)
    end

    it "destroys basket lines" do
      expect(BasketLine.all.size).to eq(0)
    end
  end
end