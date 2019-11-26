require "rails_helper"
require "helpers/product_helper" #includes seller_helper

RSpec.describe "Object translate - ", type: :feature do

  context "product translation - " do

    context "when available - " do

      before do
        product = create_valid_product
        add_translation_to_product(product: product, description: "Description en français")
        visit product_path("fr", product)
      end

      it "translates from the DB" do
        expect(page).to have_text("Description en français")
      end
    end

    context "when not available - " do

      before do
        product = create_valid_product
        visit product_path("fr", product)
      end

      it "returns the default language" do
        expect(page).to have_text("Product description")
      end
    end
  end

  context "seller translation - " do

    context "when available - " do

      before do
        seller = create(:seller, translations: "en|fr")
        add_translation_to_seller(seller: seller, description: "Description en français")
        visit c_seller_path("fr", seller)
      end

      it "translates from the DB" do
        expect(page).to have_text("Description en français")
      end
    end

    context "when not available - " do

      before do
        seller = create(:seller)
        visit c_seller_path("en", seller)
      end

      it "returns the default language" do
        expect(page).to have_text("Seller Name")
        expect(page).to have_text("Seller description")
      end
    end
  end

  context "category translation - " do

    before do
      create(:category_translation)
      two = create(:category, name: "Category two")
      create(:category_translation, name: "Catégorie deux", category: two)
      Categorize.define_all_as_hash
    end

    it "makes a hash available with all categories for each language" do
      expect(Category.all_as_hash["en"][0][0]).to eq("Category one")
      expect(Category.all_as_hash["en"][1][0]).to eq("Category two")
      expect(Category.all_as_hash["fr"][0][0]).to eq("Catégorie une")
      expect(Category.all_as_hash["fr"][1][0]).to eq("Catégorie deux")
      #testing for correct ids
      expect(Category.all_as_hash["fr"][0][1]).to eq(Category.all_as_hash["en"][0][1])
      expect(Category.all_as_hash["fr"][1][1]).to eq(Category.all_as_hash["en"][1][1])
    end
  end
end
