require "rails_helper"

RSpec.describe "Devise for admin_user", type: :feature do

  it "can create session if admin_user is registered" do
    create(:admin_user)
    visit new_admin_user_session_path
    fill_in "admin_user_email", with: "admin@mp.com"
    fill_in "admin_user_password", with: "password"
    click_button "Login"

    expect(current_path).to eq "/admin"
    expect(page).to have_text("Signed in successfully.")
  end

  it "cant create session admin_user is not registered" do
    visit new_admin_user_session_path
    fill_in "admin_user_email", with: "not_there@mp.com"
    fill_in "admin_user_password", with: "password"
    click_button "Login"

    expect(current_path).to eq "/en/admin/login"
    expect(page).to have_text("Invalid Email or password.")
  end
end
