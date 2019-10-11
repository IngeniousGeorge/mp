require "rails_helper"
require "helpers/location_helper"

RSpec.describe "Location - ", type: :feature do

  it "allows location to save with coordinates" do
    client = create(:client)
    sign_in_client
    visit client_dashboard_path("en", client.slug)
    fill_in_good_address

    expect(page).to have_text("Address was successfully created")
  end

  it "doesn't allow location to save without coordinates on create" do
    client = create(:client)
    sign_in_client
    visit client_dashboard_path("en", client.slug)
    fill_in_bad_address

    expect(page).to have_text("Address couldn't be recognized, please try again")
  end

  it "doesn't allow location to save without coordinates on edit" do
    client = create(:client)
    sign_in_client
    visit client_dashboard_path("en", client.slug)
    fill_in_good_address
    edit_address_with_unrecognizable_address

    expect(page).to have_text("Address couldn't be recognized, please try again")
  end

end