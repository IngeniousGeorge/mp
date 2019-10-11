require "rails_helper"
require "helpers/product_helper"

RSpec.describe "Product - ", type: :feature do

  it "gets an associated tag on create" do
    set_create_context
    create_with_two_tags

    expect(page).to have_text("Product was successfully created")
    expect(ProductTag.count).to eq(2)
    expect(ProductTag.take.product_id).to eq(Product.find_by_name("Product Name").id)
  end

end
