require "rails_helper"
require "helpers/seller_helper"

RSpec.describe "Seller - ", type: :feature do

  context "can edit covers and images - " do

    it "edits a seller cover image" do
      set_seller_edit_context
      change_seller_cover

      expect(page).to have_text("Cover was successfully updated")
    end


  #   it "adds an image" do
  #     set_edit_context
  #     add_image

  #     expect(page).to have_text("Image was successfully added")
  #   end

  #   it "deletes an image" do
  #     set_edit_context
  #     delete_image

  #     expect(page).to have_text("Image was successfully deleted")
  #   end
  # end

  end


  # def set_create_context
  #   create(:category)
  #   seller = create(:seller)
  #   visit new_seller_session_path
  #   fill_in "seller_email", with: "jim@mp.com"
  #   fill_in "seller_password", with: "password"
  #   click_button "Sign in"
  #   visit seller_dashboard_path("en", seller.slug)
  # end

  # def add_product_with_both
  #   within("#new_product") do 
  #     attach_file "product_cover", "spec/files/test.jpeg"
  #     attach_file "product_images", "spec/files/test.jpeg"
  #     fill_in_form
  #     click_button "Create"
  #   end
  # end
  
  # def add_product_without_cover
  #   within("#new_product") do 
  #     attach_file "product_images", "spec/files/test.jpeg"
  #     fill_in_form
  #     click_button "Create"
  #   end
  # end
  
  # def add_product_without_image
  #   within("#new_product") do 
  #     attach_file "product_cover", "spec/files/test.jpeg"
  #     fill_in_form
  #     click_button "Create"
  #   end
  # end

  # def fill_in_form
  #   fill_in "product_price", with: 1000
  #   fill_in "product_price_excl_vat", with: 800
  # end

  # def set_edit_context
  #   product = build(:product)
  #   product.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
  #   product.images.attach(io: File.open('/home/ig/Code/mp/spec/files/test.jpeg'), filename: 'test.jpeg')
  #   product.save
  #   visit new_seller_session_path
  #   fill_in "seller_email", with: "jim@mp.com"
  #   fill_in "seller_password", with: "password"
  #   click_button "Sign in"
  #   visit seller_dashboard_path("en", product.seller.slug)
  # end

  # def change_cover
  #   within("#product_cover_chocolate") do 
  #     attach_file "product_cover", "spec/files/test2.png"
  #     click_button "Submit"
  #   end
  # end

  # def add_image
  #   within("#new_image_chocolate") do 
  #     attach_file "product_image", "spec/files/test2.png"
  #     click_button "Submit"
  #   end
  # end

  # def delete_image
  #   within(".del_img") do 
  #     click_button "Delete"
  #   end
  # end
end