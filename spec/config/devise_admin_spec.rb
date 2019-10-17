require "rails_helper"
require "helpers/admin_user_helper"

RSpec.describe "Devise for admin_user - ", type: :feature do

  it "can create session if admin_user is registered" do
    create(:admin_user)
    sign_in_admin_user

    expect(current_path).to eq("/admin")
    expect(page).to have_text("Signed in successfully.")
  end

  it "cant create session admin_user is not registered" do
    sign_in_admin_user

    expect(current_path).to eq("/en/admin/login")
    expect(page).to have_text("Invalid Email or password.")
  end
  
end