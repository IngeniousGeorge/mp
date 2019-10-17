require "rails_helper"
require "helpers/product_helper"

RSpec.describe "I18n", type: :feature do

  it "can nest the current language in the URL" do
    visit "/fr/catalogue"

    expect(page.status_code).to eq(200)
  end

  it "can translate strings with t(:something) method" do
    visit "/fr"

    expect(page).to have_text("Partenaires")
  end

  it "can translate text from the DB" do
    product = create_valid_product
    add_translation_to_product(product: product, name: "Nom", description: "Description en français")
    visit product_path("fr", product)

    expect(page).to have_text("Nom")
    expect(page).to have_text("Description en français")
  end

  xit "can translate categories"


  xit "doesn't have any missing translations"

end