require "rails_helper"
require "helpers/client_helper"

RSpec.describe "Authorisation for Create, Update, Destroy - ", type: :request do

  context "client - " do

    # context "test " do
    #   it "get request" do
    #     @client = create(:client, name: "client")
    #     get client_dashboard_path("en", "client")

    #     expect(response.body).to eq(1)
    #   end
    # end

    # context "location - " do

    #   before do
    #     @hacker = create(:client, name: "hacker", email: "hack@email.com")
    #     @client = create(:client, name: "client")
    #   end

    #   it "doesn't authorize operations if client isn't signed in" do
    #     post "/en/c/client/l", :params => { :location =>  
    #       { "name"=>"Office", "recipient"=>"Client", "street"=>"15 rue des Chenes", "city"=>"Montbert", "state"=>"Pays-de-la-Loire", "country"=>"France", "postal_code"=>"44140", "delivery"=>"0", "billing"=>"0", "owner_type"=>"Client", "owner_id"=>"#{@client.id}" }}

    #       follow_redirect!
    #     expect(response.body).to eq(0)
    #   end
    # end
  end
end