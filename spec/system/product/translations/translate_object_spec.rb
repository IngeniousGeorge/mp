require "rails_helper"
require "helpers/product_helper"

RSpec.describe "Object extension translate_object - ", type: :feature do

  it "can translate any object" do
    product = create_valid_product
    add_translation_to_product(product: product, name: "Nom", description: "Description en français")
    translated = product.translate_object("fr")

    expect(translated.name).to eq("Nom")
    expect(translated.description).to have_text("Description en français")
  end

  it "keeps the other attributes as before" do
    product = create_valid_product
    add_translation_to_product(product: product, name: "Nom", description: "Description en français")
    translated = product.translate_object("fr")

    expect(translated.id).to eq(product.id)
    expect(translated.seller_id).to have_text(product.seller_id)
  end

end


