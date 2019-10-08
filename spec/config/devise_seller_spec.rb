require "rails_helper"

RSpec.describe "Devise for seller", type: :feature do

  it "can create session if seller is registered" do
    create(:seller)
    visit new_seller_session_path
    fill_in "seller_email", with: "jim@mp.com"
    fill_in "seller_password", with: "password"
    click_button "Sign in"

    expect(current_path).to eq "/en"
    expect(page).to have_selector(".alert", text: "Signed in successfully.")
  end

  it "cant create session seller is not registered" do
    visit new_seller_session_path
    fill_in "seller_email", with: "not_there@mp.com"
    fill_in "seller_password", with: "password"
    click_button "Sign in"

    expect(current_path).to eq "/en/sellers/sign_in"
    expect(page).to have_selector(".alert", text: "Invalid Email or password.")
  end
end