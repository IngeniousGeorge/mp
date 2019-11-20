require "rails_helper"
require "helpers/product_helper"

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
      visit catalogue_path("en")
      # save_and_open_page

      expect(page).to have_text("Product Name 1")
      expect(page).to have_text("Product Name 8")
      expect(page).to have_content("Product Name", count: 8)
    end

    it "can retrieve 8 more products on page 2" do
      visit catalogue_path("en", 2)
    end

    xit "can order products by price"

    xit "can order products by distance to the seller"

  end


  # context "search - " do


  # end

end