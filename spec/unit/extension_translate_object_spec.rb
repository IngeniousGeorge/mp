require "rails_helper"
require "helpers/product_helper" #includes seller_helper

RSpec.describe "Object extension translate_object - " do

    before do
      @product = create_valid_product
      add_translation_to_product(product: @product, name: "Nom", description: "Description en français")
      @translated = @product.translate_object("fr")
    end

    it "can translate any object" do
      expect(@translated.name).to eq("Nom")
      expect(@translated.description).to eq("Description en français")
    end

    it "keeps the other attributes as before" do
      expect(@translated.id).to eq(@product.id)
      expect(@translated.seller_id).to eq(@product.seller_id)
    end

    it "doesn't update the object itself" do
      expect(@product.name).to eq("Product Name")
      expect(@product.description).to eq("Product description")
    end

    xit "also translates parents and their attributes"
end