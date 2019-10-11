require "rails_helper"
require "helpers/seller_helper"

RSpec.describe "Seller - ", type: :feature do

  context "can edit covers and images - " do

    it "edits a seller cover image" do
      set_seller_edit_context
      change_seller_cover

      expect(page).to have_text("Cover was successfully updated")
    end

    it "adds an image" do
      set_seller_edit_context
      add_seller_image

      expect(page).to have_text("Image was successfully added")
    end

    it "deletes an image" do
      set_seller_edit_context
      add_seller_image
      delete_seller_image

      expect(page).to have_text("Image was successfully deleted")
    end
  end
end
