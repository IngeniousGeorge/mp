require "rails_helper"
require "helpers/product_helper" #includes seller_helper

RSpec.describe "Seller - ", type: :feature do

  before { @seller = return_seller_with_purged_image }
  
  it "displays the seller show page without images" do
    visit seller_show_path("en", @seller.slug)

    expect(page).to have_text(@seller.name)
  end

  it "displays the seller index page without images" do
    visit sellers_path("en")

    expect(page).to have_text(@seller.name)
  end
end