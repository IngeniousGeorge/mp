require "helpers/client_helper"

def fill_in_good_address
  within("#new_address") do
    fill_in "location_name", with: "Good Address"
    fill_in "location_recipient", with: "Recipient"
    fill_in "location_street", with: "15 rue des Chenes"
    fill_in "location_city", with: "Montbert"
    fill_in "location_state", with: "Pays-de-la-Loire"
    fill_in "location_country", with: "France"
    fill_in "location_postal_code", with: "44140"
    click_button "Create"
  end
end

def fill_in_bad_address
  within("#new_address") do
    fill_in "location_name", with: "Bad Address"
    fill_in "location_recipient", with: "Recipient"
    fill_in "location_street", with: "15"
    fill_in "location_city", with: "Paris"
    fill_in "location_state", with: "Pays-de-la-Loire"
    fill_in "location_country", with: "Germany"
    fill_in "location_postal_code", with: "001"
    click_button "Create"
  end
end

def edit_address_with_unrecognizable_address
  within("#good-address") do
    fill_in "location_name", with: "Bad Address"
    fill_in "location_recipient", with: "Recipient"
    fill_in "location_street", with: "15"
    fill_in "location_city", with: "Paris"
    fill_in "location_state", with: "Pays-de-la-Loire"
    fill_in "location_country", with: "Germany"
    fill_in "location_postal_code", with: "001"
    click_button "Edit"
  end
end