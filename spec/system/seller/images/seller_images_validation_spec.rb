require "rails_helper"
require "helpers/seller_helper"

RSpec.describe "Seller - ", type: :feature do

  context "can edit covers and images - " do

    before { set_seller_edit_context }

    it "edits a seller cover image" do
      change_seller_cover

      expect(page).to have_text("Cover was successfully updated")
    end

    xit "adds an image" do
      add_seller_image

      expect(page).to have_text("Image was successfully added")
    end

    xit "deletes an image" do
      add_seller_image
      delete_seller_image

      expect(page).to have_text("Image was successfully deleted")
    end
  end
end
