require "rails_helper"
require "helpers/product_helper" #includes seller_helper

RSpec.describe "Object translate - ", type: :feature do

  context "product translation - " do

    context "when available - " do

      before do
        product = create_valid_product
        add_translation_to_product(product: product, name: "Nom", description: "Description en français")
        visit product_path("fr", product)
      end

      it "translates from the DB" do
        expect(page).to have_text("Nom")
        expect(page).to have_text("Description en français")
      end
    end

    context "when not available - " do

      before do
        product = create_valid_product
        visit product_path("fr", product)
      end

      it "returns the default language" do
        expect(page).to have_text("Product Name")
        expect(page).to have_text("Product description")
      end
    end
  end

  context "seller translation - " do

    context "when available - " do

      before do
        seller = create(:seller)
        add_translation_to_seller(seller: seller, description: "Description en français")
        visit seller_show_path("fr", seller)
      end

      it "translates from the DB" do
        expect(page).to have_text("Description en français")
      end
    end

    context "when not available - " do

      before do
        seller = create(:seller)
        visit seller_show_path("fr", seller)
      end

      it "returns the default language" do
        expect(page).to have_text("Seller Name")
        expect(page).to have_text("Seller description")
      end
    end
  end


  context "category translation - " do


  end
end