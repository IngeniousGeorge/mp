require "rails_helper"
require "helpers/product_helper"

RSpec.describe "Product - ", type: :feature do

  before { @product = return_product_with_purged_image }
  
  it "displays the product index without images" do
    visit catalogue_path

    expect(page).to have_text(@product.name)
  end

  it "displays the product show page without images" do
    seller_attach_images(@product.seller)
    visit product_path("en", @product.slug)

    expect(page).to have_text(@product.name)
  end
end