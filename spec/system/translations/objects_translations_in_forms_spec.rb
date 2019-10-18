require "rails_helper"
require "helpers/product_helper" #includes seller_helper

RSpec.describe "Object translation in forms - ", type: :feature do

  context "product - " do

    context "with translation - " do

      before do
        set_create_context
        fill_in_create_form
        attach_required_images
        fill_in_translation_form
        within("#new_product") { click_button "Create" }
        @product = last_created_product
      end

      it "renders the dashboard with an alert success" do
        expect(page).to have_selector(".alert-success")
      end

      it "saves a ProductTranslation object on create" do
        expect(ProductTranslation.count).to eq(1)
      end

      it "sets the correct value in translations attribute" do
        expect(@product.translations).to eq("en|fr")
      end
    end

    context "without translation - " do

      before do
        set_create_context
        fill_in_create_form
        attach_required_images
        within("#new_product") { click_button "Create" }
        @product = last_created_product
      end

      it "renders the dashboard with an alert success" do
        expect(page).to have_selector(".alert-success")
      end

      it "doesn't save a ProductTranslation object on create" do
        expect(ProductTranslation.count).to eq(0)
      end

      it "sets the correct value in translations attribute" do
        expect(@product.translations).to eq("en")
      end

    end

  context "seller - " do

  end
  end
end
