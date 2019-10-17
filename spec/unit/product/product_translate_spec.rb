require "rails_helper"
require "helpers/product_helper"

RSpec.describe "Product translate - " do

  context "when available - " do

    before do
      @product = create_valid_product
      add_translation_to_product(product: @product, name: "Nom", description: "Description en français")
      @translated = @product.translate_object("fr")
    end

    it "gets its name and description translated" do
      expect(@translated.name).to eq("Nom")
    end

    it "doesn't update the actual object" do
      expect(@product.name).to eq("Product Name")
    end

    xit "also translates the seller"

  end

  context "when not available - " do

    it "returns the default language" do
      product = create_valid_product
      translated = product.translate_object("fr")

      expect(product.name).to eq("Product Name")
      expect(translated.name).to eq("Product Name")
    end
  end
end