# context "catalogue"
# it "creates new line if doesn't exist"
# it "updates existing line if exists"
# it "can add a specific value"
# it "can subtract a specific value"
# it "can set an absolute value"
# it "can delete a line"

require "rails_helper"
require "helpers/basket_helper" #includes client_helper, product_helper

RSpec.describe "Basket lines - ", type: :feature do

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

  end

end

