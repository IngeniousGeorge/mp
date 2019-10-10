require "rails_helper"

RSpec.describe "Product controller", type: :feature do

  context "validates the presence of a logo and one image before save" do

    it "creates a product with both logo and image" do
      set_context
      add_product_with_both

      expect(page).to have_text("Product was successfully created")
    end

    it "doesn't create a product without a logo" do
      set_context
      add_product_without_logo

      expect(page).to have_text("Products require one cover image and at least one other image")
    end

    it "doesn't create a product without at least one image" do
      set_context
      add_product_without_image

      expect(page).to have_text("Products require one cover image and at least one other image")
    end

    # it "edits a product with both logo and image" do
    #   set_context
    #   edit_product_with_both

    #   expect(page).to have_text("Product was successfully updated")
    # end

    # it "doesn't edit a product without a logo" do
    #   set_context
    #   edit_product_without_logo

    #   expect(page).to have_text("Product wasn't successfully updated")
    # end

    # it "doesn't edit a product without at least one image" do
    #   set_context
    #   edit_product_without_logo

    #   expect(page).to have_text("Product wasn't successfully updated")
    # end

  end


  def set_context
    create(:category)
    seller = create(:seller)
    # product = create(:product)
    # product = build(:product).save(validate: false)
    visit new_seller_session_path
    fill_in "seller_email", with: "jim@mp.com"
    fill_in "seller_password", with: "password"
    click_button "Sign in"
    visit seller_dashboard_path("en", seller.slug)
  end

  def add_product_without_image
    within("#new_product") do 
      attach_file "product_logo", "spec/files/test.jpeg"
      # fill_in "product_name", with: "prod"
      # fill_in "product_slug", with: "prod"
      fill_in "product_price", with: 1000
      fill_in "product_price_excl_vat", with: 800
      click_button "Create"
    end
  end

  def add_product_without_logo
    within("#new_product") do 
      attach_file "product_images", "spec/files/test.jpeg"
      # fill_in "product_name", with: "prod"
      # fill_in "product_slug", with: "prod"
      fill_in "product_price", with: 1000
      fill_in "product_price_excl_vat", with: 800
      click_button "Create"
    end
  end

  def add_product_with_both
    within("#new_product") do 
      attach_file "product_logo", "spec/files/test.jpeg"
      attach_file "product_images", "spec/files/test.jpeg"
      # fill_in "product_name", with: "prod"
      # fill_in "product_slug", with: "prod"
      fill_in "product_price", with: 1000
      fill_in "product_price_excl_vat", with: 800
      click_button "Create"
    end
  end

  def edit_product_with_both
    within("#chocolate-jim") do 
      attach_file "product_logo", "spec/files/test.jpeg"
      attach_file "product_images", "spec/files/test.jpeg"
      click_button "Edit"
    end
  end

  def edit_product_without_logo
    within("#chocolate-jim") do 
      attach_file "product_images", "spec/files/test.jpeg"
      click_button "Edit"
    end
  end

  def edit_product_without_image
    within("#chocolate-jim") do 
      attach_file "product_logo", "spec/files/test.jpeg"
      click_button "Edit"
    end
  end

end
