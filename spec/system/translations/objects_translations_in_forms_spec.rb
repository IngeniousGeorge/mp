require "rails_helper"
require "helpers/product_helper" #includes seller_helper

RSpec.describe "Object translation in forms - ", type: :feature do

  context "product - " do

    context "create - " do

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
    end

    context "edit - " do

      context "with translation - " do

        before do
          set_product_edit_context
          edit_translation
        end
        
        it "renders the dashboard with an alert success" do
          expect(page).to have_selector(".alert-success")
        end
        
        it "updates the edited translation object on edit" do
          translation = last_edited_translation

          expect(translation.description).to eq("edited description en français")
        end
      end

      context "removing translation - " do

        before do
          set_product_edit_context
          remove_translation
        end

        it "renders the dashboard with an alert success" do
          expect(page).to have_selector(".alert-success")
        end

        xit "sets the correct value in translations attribute" do
          product = last_edited_product

          expect(product.translations).to eq("en")
        end

        xit "deletes the ProductTranslation record"

      end

      context "removing default language - " do

        before do
        end

        xit "renders the dashboard with an alert success" do
          expect(page).to have_selector(".alert-success")
        end

        xit "sets the product_description to null"

        xit "sets the correct value in translations attribute" do
          expect(@product.translations).to eq("fr")
        end
      end
    end
  end

  context "seller - " do

    context "edit - " do

      context "with translation - " do

        before do
          set_seller_edit_context
          edit_seller_translation
        end
        
        xit "renders the dashboard with an alert success" do
          expect(page).to have_selector(".alert-success")
        end
        
        xit "updates the edited translation object on edit" do
          translation = last_edited_seller_translation

          expect(translation.description).to eq("edited description en français")
        end
      end

      context "removing translation - " do

        before do
          set_product_edit_context
          remove_translation
        end

        it "renders the dashboard with an alert success" do
          expect(page).to have_selector(".alert-success")
        end

        xit "sets the correct value in translations attribute" do
          product = last_edited_product

          expect(product.translations).to eq("en")
        end

        xit "deletes the ProductTranslation record"

      end

      context "removing default language - " do

        before do
        end

        xit "renders the dashboard with an alert success" do
          expect(page).to have_selector(".alert-success")
        end

        xit "sets the product_description to null"

        xit "sets the correct value in translations attribute" do
          expect(@product.translations).to eq("fr")
        end
      end
    end
  end
end