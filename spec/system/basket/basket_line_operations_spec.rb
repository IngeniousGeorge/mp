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

  context "from dashboard or checkout - " do

    it "can add a specific value" do

    end

    it "can subtract a specific value" do

    end
    # it "can set an absolute value"
    # it "can delete a line"

  end

end





