require "rails_helper"

RSpec.describe "Product controller - ", type: :feature do

  def create_product
    product = build(:product)
    product.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
    product.images.attach(io: File.open('/home/ig/Code/mp/spec/files/test.jpeg'), filename: 'test.jpeg')
    product.save
    product.cover.purge
    product.images.purge
    return product
  end
  
  it "displays the product index without images" do
    product = create_product
    visit catalogue_path

    expect(page).to have_text(product.name)
  end

  it "displays the product show page without images" do
    product = create_product
    visit product_path("en", product.slug)

    expect(page).to have_text(product.name)
  end

end
