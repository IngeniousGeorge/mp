require "rails_helper"
require "helpers/client_helper"

RSpec.describe "Client -", type: :feature do

  xit "can deactivate their account" do
    sign_up_client
    visit client_dashboard_path("en", Client.take.slug)
    deactivate_client

    expect(page).to have_selector(".alert-success")
  end
end