require "rails_helper"
require "helpers/location_helper"

RSpec.describe "Location - ", type: :feature do

  it "allows location to save with coordinates" do
    client = create(:client)
    sign_in_client
    visit client_dashboard_path("en", client.slug)
    fill_in_address

    expect(page).to have_selector(".alert-success")
    expect(Location.count).to eq(1)
  end

  it "doesn't allow location to save without coordinates on create" do
    client = create(:client)
    sign_in_client
    visit client_dashboard_path("en", client.slug)
    fill_in_address(street: "none", city: "none", country: "none", postal_code: 0101)

    expect(page).to have_selector(".alert-danger")
    expect(Location.count).to eq(0)
  end

  it "changes coordinates on successful edit" do
    client = create(:client)
    sign_in_client
    visit client_dashboard_path("en", client.slug)
    fill_in_address
    lat = Location.take.latitude
    lon = Location.take.longitude
    edit_address(street: "Stuttgarterstr. 17", city: "Berlin", state: "", country: "Deutschland", postal_code: 12059)

    expect(page).to have_selector(".alert-success")
    expect(Location.count).to eq(1)
    expect(Location.take.latitude).not_to eq(lat)
    expect(Location.take.longitude).not_to eq(lon)
  end

  it "doesn't allow location to save without coordinates on edit" do
    client = create(:client)
    sign_in_client
    visit client_dashboard_path("en", client.slug)
    fill_in_address(name: "Valid Address")
    edit_address(street: "none", city: "none", country: "none", postal_code: 0101)

    expect(page).to have_selector(".alert-danger")
    expect(Location.take.name).to eq("Valid Address")
  end

end