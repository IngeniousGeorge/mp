require "rails_helper"
require "helpers/client_helper.rb"

RSpec.describe "Devise for client", type: :feature do

  it "can register with valid data" do
    sign_up_client("password")

    expect(current_path).to eq "/en"
    expect(page).to have_selector(".alert", text: "Welcome! You have signed up successfully.")
    expect(Client.count).to eq 1
  end

  it "cant register if password too short" do
    sign_up_client("pass")

    expect(current_path).to eq "/en/clients"
    expect(page).to have_selector("#error_explanation", text: "1 error prohibited this client from being saved:")
  end

  it "can create session if client is registered" do
    create(:client)
    sign_in_client

    expect(current_path).to eq "/en"
    expect(page).to have_selector(".alert", text: "Signed in successfully.")
  end

  it "cant create session client is not registered" do
    sign_in_client

    expect(current_path).to eq "/en/clients/sign_in"
    expect(page).to have_selector(".alert", text: "Invalid Email or password.")
  end
end