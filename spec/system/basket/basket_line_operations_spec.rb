require "rails_helper"
require "helpers/basket_helper" #includes client_helper, product_helper

RSpec.describe "Basket lines - ", type: :feature do

  context "from catalogue - " do

    it "creates new line if product isn't in basket" do
      product = create_valid_product
      add_product_to_basket
      bl = last_created_basket_line

      expect(BasketLine.count).to eq(1)
      expect(bl.product_id).to eq(product.id)
      expect(bl.quantity).to eq(1)
    end

    it "updates existing line if product is already in basket" do
      product = create_valid_product
      3.times { add_product_to_basket }
      bl = last_created_basket_line

      expect(BasketLine.count).to eq(1)
      expect(bl.product_id).to eq(product.id)
      expect(bl.quantity).to eq(3)
    end

    it "can add a specific value" do
      product = create_valid_product
      add_specific_value_to_basket(5)
      bl = last_created_basket_line

      expect(BasketLine.count).to eq(1)
      expect(bl.product_id).to eq(product.id)
      expect(bl.quantity).to eq(5)
    end

  end

  context "from dashboard - " do

    it "can set a value" do
      product = create_valid_product
      sign_up_client
      client = last_created_client
      add_product_to_basket
      edit_dashboard_basket_line(client, 7)
      bl = last_created_basket_line
  
      expect(BasketLine.count).to eq(1)
      expect(bl.client).to eq(client)
      expect(bl.product_id).to eq(product.id)
      expect(bl.quantity).to eq(7)
    end

    it "can remove a line" do
      create_valid_product
      sign_up_client
      client = last_created_client
      add_product_to_basket
      remove_dashboard_basket_line(client)
  
      expect(BasketLine.count).to eq(0)
    end

    it "deletes a line if quantity is zero or less" do
      create_valid_product
      sign_up_client
      client = last_created_client
      add_product_to_basket
      edit_dashboard_basket_line(client, 0)
 
      expect(BasketLine.count).to eq(0)
    end

  end

  context "from checkout - " do

    xit "can set a value"
    xit "can delete a line"

  end

end





