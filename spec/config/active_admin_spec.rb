require "rails_helper"

RSpec.describe "ActiveAdmin", type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:all) do
    @admin = AdminUser.new(email: "admin@example.com", password: "password").save
  end

  def login(password)
    visit new_admin_user_session_path
    fill_in "admin_user_email", with: "admin@example.com"
    fill_in "admin_user_password", with: password
    click_button "Login"
  end

  it "can access dashboard" do
    login("password")

    expect(page).to have_current_path admin_root_path
  end

  it "can't access its dashboard with wrong credentials" do
    login("wrong_password")

    expect(page).to have_current_path("/#{I18n.locale}/admin/login")
  end

  xit "can create new objects from dashboard" do
    login("password")
    visit new_admin_object_path
    fill_in "object_value", with: "something"
    click_button "Create Object"

    expect(Object.take.value).to eq "something"
  end

  xit "can edit objects from dashboard" do
    login("password")

  end

  xit "can delete objects from dashboard" do
    login("password")

  end

end
