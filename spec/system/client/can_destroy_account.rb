require "rails_helper"
require "helpers/client_helper"

RSpec.describe "Client -", type: :feature do

  it "can destroy their account" do
    sign_up_client
    visit client_dashboard_path("en", Client.take.slug)
    destroy_client

    expect(page).to have_selector(".alert-success")
    expect(Client.all)to eq(1)
    # expect(current_path).not_to eq("/en/clients/sign_in")
  end
  