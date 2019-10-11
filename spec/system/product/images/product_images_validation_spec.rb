require "rails_helper"
require "helpers/product_helper"

RSpec.describe "Product - ", type: :feature do

  context "validates the presence of a cover and one image before save - " do

    it "doesn't create a product without a cover" do
      set_create_context
      add_product_without_cover
      
      expect(page).to have_text("Products require one cover image and at least one other image")
    end
    
    it "doesn't create a product without at least one image" do
      set_create_context
      add_product_without_image
      
      expect(page).to have_text("Products require one cover image and at least one other image")
    end
    
    it "creates a product with both cover and image" do
      set_create_context
      add_product_with_cover_and_image

      expect(page).to have_text("Product was successfully created")
    end

  end

  context "can edit covers and images - " do

    it "edits a product cover image" do
      set_product_edit_context
      change_product_cover

      expect(page).to have_text("Cover was successfully updated")
    end

    it "adds an image" do
      set_product_edit_context
      add_product_image

      expect(page).to have_text("Image was successfully added")
    end

    it "deletes an image" do
      set_product_edit_context
      delete_product_image

      expect(page).to have_text("Image was successfully deleted")
    end
  end
end