require "rails_helper"
require "helpers/admin_user_helper"
require "helpers/seller_helper"

RSpec.describe "ActiveAdmin - ", type: :feature do
  # include Devise::Test::IntegrationHelpers

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

    xit ""

  end

end





