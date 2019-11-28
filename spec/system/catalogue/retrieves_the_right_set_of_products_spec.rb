require "rails_helper"
require "helpers/product_helper"
require "helpers/category_helper"

RSpec.describe "Catalogue path - ", type: :feature do

  context "all" do

    before do
      create_valid_product
    end

    it "retrieves all products in default locale" do
      visit catalogue_path("en")

      expect(page).to have_text("Product Name")
    end
  end

  context "locales - " do

    before do
      with_translation = create_valid_product({description: "With translation", translations: "en|fr"})
      add_translation_to_product(product: with_translation, description: "Description en français")
      create_valid_product({description: "Without translation", translations: "en"}, with_translation.seller)
    end

    context "the client made no selection - " do

      it "retrieves all products in default locale" do
        visit catalogue_path("en")

        expect(page).not_to have_text("Description en français")
        expect(page).to have_text("With translation")
        expect(page).to have_text("Without translation")
      end
    end

    context "the client selected a language - " do

      it "only retrieves products with translations" do
        visit catalogue_path("fr")

        expect(page).to have_text("Description en français")
        expect(page).not_to have_text("With translation")
        expect(page).not_to have_text("Without translation")
      end
    end
  end

  context "pagination & ordering - " do

    before do
      seller = create(:seller)
      20.times do |i|
        create_valid_product({name: "Product Name #{i}", price: (i * 1000)}, seller)
      end
    end

    it "shows 8 products per page" do
      visit "en/catalogue"

      expect(page).to have_text("Product Name 0")
      expect(page).to have_text("Product Name 7")
      expect(page).to have_content("Product Name", count: 8)
    end

    it "can retrieve 8 more products on page 2" do
      visit "en/catalogue?page=2"

      expect(page).to have_text("Product Name 8")
      expect(page).to have_text("Product Name 15")
      expect(page).to have_content("Product Name", count: 8)
    end

    it "can show more products per page" do
      visit "en/catalogue?limit=20"

      expect(page).to have_text("Product Name 0")
      expect(page).to have_text("Product Name 19")
    end

    it "can order products by price" do
      visit "en/catalogue?sort=price"

      expect(page).to have_text("Product Name 0")
      expect(page).not_to have_text("Product Name 15")
    end

    it "can order products by price descending" do
      visit "en/catalogue?sort=price&order=desc"

      expect(page).to have_text("Product Name 15")
      expect(page).not_to have_text("Product Name 0")
    end

    xit "can order products by distance to the seller"

  end

  context "category - " do

    before do
      @category = create(:category, name: "Retail", description: "something")
      attach_cover_to_categories
      seller = create(:seller)
      create_valid_product({name: "Retail product", category: @category.id}, seller)
      create_valid_product({name: "Food product", category: "eedd3dcd-f40d-4225-a617-34eb2b734c73"}, seller)
    end

    it "can retrieve products of a given category through url" do
      Categorize.define_all_as_hash
      visit "en/c/Retail"

      expect(page).to have_text("Retail product")
      expect(page).not_to have_text("Food product")
    end

    it "can retrieve products of a given category through query" do
      visit "en/catalogue?category=#{@category.name}"

      expect(page).to have_text("Retail product")
      expect(page).not_to have_text("Food product")
    end
  end

  context "seller - " do

    before do
      seller = create(:seller, name: "Expected", slug: "expected")
      seller_attach_images(seller)
      other_seller = create(:seller, name: "Other", email: "other@email.com")
      create_valid_product({name: "Expected product"}, seller)
      create_valid_product({name: "Other product"}, other_seller)
    end

    it "can retrieve products of a given seller through url" do
      visit "en/s/expected"

      expect(page).to have_text("Expected product")
      expect(page).not_to have_text("Other product")
    end

    it "can retrieve products of a given seller through query" do
      visit "en/catalogue?seller=expected"

      expect(page).to have_text("Expected product")
      expect(page).not_to have_text("Other product")
    end
  end

  context "tag - " do

    before do
      product = create_valid_product({name: "Tagged product"})
      create(:product_tag, tag: "example", product: product)
      create_valid_product({name: "Other product"}, product.seller)
    end

    it "can retrive the product corresponding to the tag" do
      visit "en/catalogue?tag=example"

      expect(page).to have_text("Tagged product")
      expect(page).not_to have_text("Other product")
    end
  end

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

    it "can retrieve a product with a matching description in another language" do
      product = create_valid_product({name: "Translated product"}, @seller)
      create(:product_translation, description: "traduit", product: product)
      visit "fr/catalogue?q=traduit"

      expect(page).to have_text("Translated product")
      expect(page).not_to have_text("First")
    end

    it "can retrieve a product with matching category" do
      category = create(:category, name: "Three")
      create_valid_product({name: "Third", category: category.id}, @seller)
      visit "en/catalogue?q=Three"

      expect(page).to have_text("Third")
      expect(page).not_to have_text("First")
    end

    it "can retrieve a product with matching tag" do
      product = create_valid_product({name: "Tagged product"}, @seller)
      create(:product_tag, tag: "fourth", product: product)
      visit "en/catalogue?q=fourth"

      expect(page).to have_text("Tagged product")
      expect(page).not_to have_text("First")
    end
  end
end
