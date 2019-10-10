require "rails_helper"

RSpec.describe "Google Cloud Storage", type: :feature do

  def set_context
    create(:category)
    product = create(:product)
    seller = product.seller
    visit new_seller_session_path
    fill_in "seller_email", with: "jim@mp.com"
    fill_in "seller_password", with: "password"
    click_button "Sign in"
    visit seller_dashboard_path("en", seller.slug)
    return product
  end

  def add_image
    within("#chocolate-jim") do 
      attach_file "product_logo", "spec/files/test.jpeg"
      click_button "Edit"
    end
  end
  
  #Products/edit - logo
  it "stores images on create" do
    product = set_context
    add_image

    expect(product.logo.attached?).to be_truthy
  end

  it "can remove images" do
    product = set_context
    add_image
    click_link "Remove cover"

    expect(product.logo.attached?).to be_falsy
  end

end
