require "rails_helper"
require "helpers/client_helper.rb"

RSpec.describe "Devise for client", type: :feature do

  it "can register with valid data" do
    sign_up_client

    expect(current_path).to eq("/en")
    expect(page).to have_selector(".alert-success")
    expect(Client.count).to eq(1)
  end

  it "can't register if password too short" do
    sign_up_client(password: "pass")

    expect(current_path).to eq("/en/clients")
    expect(page).to have_selector("#error_explanation")
  end

  it "can create session if client is registered" do
    create(:client)
    sign_in_client

    expect(current_path).not_to eq("/en/clients/sign_in")
    expect(page).to have_selector(".alert-success")
  end

  it "can't create session if client is not registered" do
    sign_in_client

    expect(current_path).to eq("/en/clients/sign_in")
    expect(page).to have_selector(".alert-danger")
  end
end
