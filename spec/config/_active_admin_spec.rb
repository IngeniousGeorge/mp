require "rails_helper"

RSpec.describe "ActiveAdmin", type: :feature do
  include Devise::Test::IntegrationHelpers

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
