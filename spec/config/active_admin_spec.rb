require "rails_helper"
require "helpers/admin_user_helper"
require "helpers/seller_helper"

RSpec.describe "ActiveAdmin - ", type: :feature do

  context "sellers - " do

    before do
      create(:admin_user)
      @seller = create(:seller)
      sign_in_admin_user
    end

    it "can create new sellers from dashboard" do
      visit new_admin_seller_path
      within("#new_seller") do
        fill_in_seller(name: "Created Seller", email: "uniq@email.com", button_text: "Create Seller")
      end

      expect(page).to have_text("Seller was successfully created.")
      expect(last_created_seller.name).to eq("Created Seller")
    end

    it "can edit seller from dashboard" do
      visit edit_admin_seller_path("en", @seller.slug)
      within("#edit_seller") do
        fill_in_seller(name: "Updated Seller", button_text: "Update Seller")
      end

      expect(page).to have_text("Seller was successfully updated.")
      expect(last_edited_seller.name).to eq("Updated Seller")
    end

    it "can delete sellers from dashboard" do
      visit admin_sellers_path
      find("a.delete_link").click

      expect(page).to have_text("Seller was successfully destroyed.")
      expect(Seller.count).to eq(0)
    end
  end

  context "categories - " do

    before do
      translation = create(:category_translation)
      @id = translation.category.id
      create(:admin_user)
      sign_in_admin_user
    end

    it "can create a new category", js: true do
      visit new_admin_category_path
      create_category_with_translation(name: "Created", translation: "Translation")

      expect(page).to have_text("Category was successfully created")
      expect(Category.count).to eq(2)
      expect(last_created_category.name).to eq("Created")
      expect(last_created_category_translation.name).to eq("Translation")
    end

    it "can edit a category with its translation", js: true do
      visit edit_admin_category_path("en", @id)
      edit_category_with_translation(name: "Edited", translation: "Edited translation")

      expect(Category.count).to eq(1)
      expect(CategoryTranslation.count).to eq(1)
      expect(last_edited_category.name).to eq("Edited")
      expect(last_edited_category_translation.name).to eq("Edited translation")
      expect(page).to have_text("Category was successfully updated")
    end

    it "can delete a category and its translation" do
      visit admin_categories_path
      delete_category

      expect(Category.count).to eq(0)
      expect(CategoryTranslation.count).to eq(0)
      expect(page).to have_text("Category was successfully destroyed")
    end
  end

end





