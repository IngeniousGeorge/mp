require "helpers/client_helper"

def fill_in_address(
    name: name="Valid Address",
    recipient: recipient="Recipient",
    street: street="15 rue des Chenes",
    city: city="Montbert",
    state: state="Pays-de-la-Loire",
    country: country="France",
    postal_code: postal_code="44140")
  within("#new_address") do
    fill_in "location_name", with: name
    fill_in "location_recipient", with: recipient
    fill_in "location_street", with: street
    fill_in "location_city", with: city
    fill_in "location_state", with: state
    fill_in "location_country", with: country
    fill_in "location_postal_code", with: postal_code
    click_button "Create"
  end
end

def edit_address(
    id: id="#valid-address",
    name: name="Valid Address",
    recipient: recipient="Recipient",
    street: street="15 rue des Chenes",
    city: city="Montbert",
    state: state="Pays-de-la-Loire",
    country: country="France",
    postal_code: postal_code="44140")
  within(id) do
    fill_in "location_name", with: name
    fill_in "location_recipient", with: recipient
    fill_in "location_street", with: street
    fill_in "location_city", with: city
    fill_in "location_state", with: state
    fill_in "location_country", with: country
    fill_in "location_postal_code", with: postal_code
    click_button "Edit"
  end
end