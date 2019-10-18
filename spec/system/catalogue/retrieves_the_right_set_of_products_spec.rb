require "rails_helper"
require "helpers/product_helper"

RSpec.describe "Catalogue path - ", type: :feature do

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


  end

  context "search - " do


  end

end