require "rails_helper"
require "helpers/seller_helper"

RSpec.describe "Devise for seller", type: :feature do

  it "can create session if seller is registered" do
    create(:seller)
    sign_in_seller

    expect(current_path).to eq("/en")
    expect(page).to have_selector(".alert-success")
  end

  it "can't create session seller is not registered" do
    sign_in_seller

    expect(current_path).to eq("/en/sellers/sign_in")
    expect(page).to have_selector(".alert-danger")
  end
end
