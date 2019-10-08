require "rails_helper"

RSpec.describe "Devise for client", type: :feature do

  it "can register with valid data" do
    visit new_client_registration_path
    fill_in "client_name", with: "test guy"
    fill_in "client_email", with: "test@test.com"
    fill_in "client_password", with: "password"
    fill_in "client_password_confirmation", with: "password"
    click_button "Sign up"

    expect(current_path).to eq "/en"
    expect(page).to have_selector(".alert", text: "Welcome! You have signed up successfully.")
    expect(Client.count).to eq 1
  end

  it "cant register if password too short" do
    visit new_client_registration_path
    fill_in "client_name", with: "test guy"
    fill_in "client_email", with: "test@test.com"
    fill_in "client_password", with: "pa"
    fill_in "client_password_confirmation", with: "pa"
    click_button "Sign up"

    expect(current_path).to eq "/en/clients"
    expect(page).to have_selector("#error_explanation", text: "1 error prohibited this client from being saved:")
  end

  it "can create session if client is registered" do
    create(:client)
    visit new_client_session_path
    fill_in "client_email", with: "joe@mp.com"
    fill_in "client_password", with: "password"
    click_button "Sign in"

    expect(current_path).to eq "/en"
    expect(page).to have_selector(".alert", text: "Signed in successfully.")
  end

  it "cant create session client is not registered" do
    visit new_client_session_path
    fill_in "client_email", with: "not_there@mp.com"
    fill_in "client_password", with: "password"
    click_button "Sign in"

    expect(current_path).to eq "/en/clients/sign_in"
    expect(page).to have_selector(".alert", text: "Invalid Email or password.")
  end
end
