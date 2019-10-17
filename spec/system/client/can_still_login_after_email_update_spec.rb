require "rails_helper"
require "helpers/client_helper"

RSpec.describe "Client -", type: :feature do

  it "can update their email and still login" do
    sign_up_client
    visit client_dashboard_path("en", Client.take.slug)
    update_client(email: "other@email.com")
    click_link "Log out"
    sign_in_client(email: "other@email.com")

    expect(current_path).not_to eq("/en/clients/sign_in")
    expect(page).to have_selector(".alert-success")
  end

end