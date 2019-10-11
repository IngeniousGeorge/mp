require "rails_helper"
require "helpers/product_helper"

RSpec.describe "Product - ", type: :feature do
  
  it "displays the product index without images" do
    product = return_product_with_purged_image
    visit catalogue_path

    expect(page).to have_text(product.name)
  end

  it "displays the product show page without images" do
    product = return_product_with_purged_image
    visit product_path("en", product.slug)

    expect(page).to have_text(product.name)
  end

end