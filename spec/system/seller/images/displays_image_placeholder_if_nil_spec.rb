require "rails_helper"
require "helpers/product_helper" #includes seller_helper

RSpec.describe "Seller - ", type: :feature do
  
  it "displays the seller show page without images" do
    seller = return_seller_with_purged_image
    visit sellers_path("en", seller.slug)

    expect(page).to have_text(seller.name)
  end

  it "displays the seller index page without images" do
    seller = return_seller_with_purged_image
    visit sellers_path("en")

    expect(page).to have_text(seller.name)
  end

end