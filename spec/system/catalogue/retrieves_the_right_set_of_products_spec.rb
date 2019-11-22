require "rails_helper"
require "helpers/product_helper"

RSpec.describe "Catalogue path - ", type: :feature do

  # context "all" do

  #   before do
  #     create_valid_product
  #   end

  #   it "retrieves all products in default locale" do
  #     visit catalogue_path("en")

  #     expect(page).to have_text("Product Name")
  #   end
  # end

  # context "locales - " do

  #   before do
  #     with_translation = create_valid_product({description: "With translation", translations: "en|fr"})
  #     add_translation_to_product(product: with_translation, description: "Description en français")
  #     create_valid_product({description: "Without translation", translations: "en"}, with_translation.seller)
  #   end

  #   context "the client made no selection - " do

  #     it "retrieves all products in default locale" do
  #       visit catalogue_path("en")

  #       expect(page).not_to have_text("Description en français")
  #       expect(page).to have_text("With translation")
  #       expect(page).to have_text("Without translation")
  #     end
  #   end

  #   context "the client selected a language - " do

  #     it "only retrieves products with translations" do
  #       visit catalogue_path("fr")

  #       expect(page).to have_text("Description en français")
  #       expect(page).not_to have_text("With translation")
  #       expect(page).not_to have_text("Without translation")
  #     end
  #   end
  # end

  # context "pagination & ordering - " do

  #   before do
  #     seller = create(:seller)
  #     20.times do |i|
  #       create_valid_product({name: "Product Name #{i}", price: (i * 1000)}, seller)
  #     end
  #   end

  #   it "shows 8 products per page" do
  #     visit "en/catalogue"

  #     expect(page).to have_text("Product Name 0")
  #     expect(page).to have_text("Product Name 7")
  #     expect(page).to have_content("Product Name", count: 8)
  #   end

  #   it "can retrieve 8 more products on page 2" do
  #     visit "en/catalogue?page=2"

  #     expect(page).to have_text("Product Name 8")
  #     expect(page).to have_text("Product Name 15")
  #     expect(page).to have_content("Product Name", count: 8)
  #   end

  #   xit "can show more products per"

  #   it "can order products by price" do
  #     visit "en/catalogue?sort=price"

  #     expect(page).to have_text("Product Name 0")
  #     expect(page).not_to have_text("Product Name 15")
  #   end

  #   xit "can order products by price descending"

  #   xit "can order products by distance to the seller"

  # end

  # context "category - " do

  #   before do
  #     seller = create(:seller)
  #     create_valid_product({name: "Retail product", category: 1}, seller)
  #     create_valid_product({name: "Food product", category: 2}, seller)
  #   end

  #   it "can retrieve products of a given category" do
  #     visit "en/catalogue?category=1"

  #     expect(page).to have_text("Retail product")
  #     expect(page).not_to have_text("Food product")
  #   end
  # end

  # context "seller - " do

  #   before do
  #     seller = create(:seller, name: "Expected", slug: "expected")
  #     other_seller = create(:seller, name: "Other", email: "other@email.com")
  #     create_valid_product({name: "Expected product"}, seller)
  #     create_valid_product({name: "Other product"}, other_seller)
  #   end

  #   it "can retrieve products of a given seller" do
  #     visit "en/catalogue?seller=expected"

  #     expect(page).to have_text("Expected product")
  #     expect(page).not_to have_text("Other product")
  #   end
  # end

  # context "tag - " do

  #   before do
  #     product = create_valid_product({name: "Tagged product"})
  #     create(:product_tag, tag: "example", product: product)
  #     create_valid_product({name: "Other product"}, product.seller)
  #   end

  #   it "can retrive the product corresponding to the tag" do
  #     visit "en/catalogue?tag=example"

  #     expect(page).to have_text("Tagged product")
  #     expect(page).not_to have_text("Other product")
  #   end
  # end

  context "search term - " do

    before do
      @seller = create(:seller)
      create_valid_product({name: "First"}, @seller)
      create_valid_product({description: "Second"}, @seller)
    end

    it "can retrieve a product with matching name" do
      visit "en/catalogue?q=First"

      expect(page).to have_text("First")
      expect(page).not_to have_text("Second")
    end

    it "can retrieve a product with matching description" do
      visit "en/catalogue?q=Second"

      expect(page).to have_text("Second")
      expect(page).not_to have_text("First")
    end

    it "can retrieve a product with matching category" do
      create(:category, name: "Third", id: 3)
      create_valid_product({category: "3"}, @seller)
      visit "en/catalogue?q=Third"

      expect(page).to have_text("Third")
      expect(page).not_to have_text("First")
    end

    # it "can retrieve a product with matching tag" do
    #   visit "en/catalogue?q=string"

    #   expect(page).to have_text("Product name")
    # end


  

  end


end

