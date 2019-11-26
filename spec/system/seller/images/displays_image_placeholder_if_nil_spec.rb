require "rails_helper"
require "helpers/product_helper" #includes seller_helper

RSpec.describe "Seller - ", type: :feature do

  before { @seller = return_seller_with_purged_image }
  
  it "displays the seller show page without images" do
    visit c_seller_path("en", @seller)

    expect(page).to have_text(@seller.name)
  end

  xit "displays the seller index page without images" do
    visit sellers_path("en")

    expect(page).to have_text(@seller.name)
  end
end