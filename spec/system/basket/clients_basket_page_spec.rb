require "rails_helper"
require "helpers/basket_helper"

RSpec.describe "Client -", type: :feature do

  context "unregisted - " do

    before do
      @product = create_valid_product
      add_product_to_basket
      @basket = Basket.take
      # save_and_open_page
    end
    
    it "can access basket page" do
      visit basket_path("en", @basket)
      
      expect(page).to have_text("Basket") #make more accurate
      expect(page).to have_text(@product.name)
    end

    it "can link to basket page from home page" do
      visit root_path
      click_link "Basket"

      expect(page).to have_text("Basket") #make more accurate
      expect(page).to have_text(@product.name)
    end

    it "gets redirected to sign up when placing order" do
      visit basket_path("en", @basket)
      click_link "Place order"

      expect(page).to have_text("Password confirmation")
    end

    it "gets redirected back to basket page after sign up" do
      visit basket_path("en", @basket)
      click_link "Place order"
      within("#new_client") do
        fill_in "client_name", with: "client name"
        fill_in "client_email", with: "client@email.com"
        fill_in "client_password", with: "password"
        fill_in "client_password_confirmation", with: "password"
      end
      click_button "Sign up"

      expect(page).to have_text("Basket") #make more accurate
      expect(page).to have_text(@product.name)
    end

    it "gets redirected back to basket page after sign in" do
      sign_up_client
      click_link "Log out"
      add_product_to_basket
      visit basket_path("en", @basket)
      click_link "Place order"
      find(:xpath, "//a[@href='/en/clients/sign_in?origin=basket']").click
      fill_in "client_email", with: "client@email.com"
      fill_in "client_password", with: "password"
      click_button "Sign in"

      expect(page).to have_text("Basket") #make more accurate
      expect(page).to have_text(@product.name)
    end
  end

  # context "registered - " do

  #   before do

  #   end
  
  #   xit "can access basket page through dashboard" do

  #   end

  #   it "can pay for all items in basket from basket page" do
  #     product = create_valid_product
  #     add_product_to_basket
  #     basket = Basket.take
  #     visit basket_path("en", basket)

  #     expect(page).to have_text("Place order")  
  #   end
  # end
end
