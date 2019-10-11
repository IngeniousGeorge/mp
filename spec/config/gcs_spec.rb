require "rails_helper"
require "helpers/product_helper"

RSpec.describe "Google Cloud Storage - ", type: :feature do
  
  #Products/create - cover
  it "stores images on create" do
    set_create_context
    add_product_with_cover_and_image

    expect(Product.last.cover.attached?).to be_truthy
  end

  #Products/edit - delete image
  it "can remove images" do
    set_create_context
    add_product_with_cover_and_image
    click_button "Delete"

    expect(Product.last.images.attached?).to be_falsy
  end

end
