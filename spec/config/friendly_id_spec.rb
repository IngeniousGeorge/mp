require "rails_helper"

RSpec.describe "FriendlyId" do

  before { create(:client, name: "joe", email: "joe@mp.com") }

  it "gives unique slugs to clients" do
    stripped_email = create(:client, name: "joe", email: "joes_stripped_email@mp.com")
    combination = create(:client, name: "joe", email: "joe@other.com")
    uuid = create(:client, name: "joe", email: "joe@another.com")

    expect(stripped_email.slug).to eq("joes_stripped_email")
    expect(combination.slug).to eq("joe-joe")
    expect(uuid.slug).to match(/^joe-.*/)
  end

  it "makes sure seller slugs are unique" do
    create(:seller, slug: "same")
    
    expect { create(:seller, name: "other", slug: "same", email: "other@mp.com") }.to raise_error(/duplicate key value/)
  end

  it "gives unique slugs to products" do
    prod = create(:product)

    expect(prod.slug).to eq("chocolate-jim")
  end

  it "gives scoped slugs to locations" do
    client_loc = create(:location)
    seller_loc = create(:location, :for_seller)

    expect(client_loc.slug).to eq("office")
    expect(Client.friendly.find("joe-loc").locations.friendly.find("office").recipient).to eq("Joe")
    expect(seller_loc.slug).to eq("office")
    expect(Seller.friendly.find("jim-loc").locations.friendly.find("office").recipient).to eq("Jim")
  end

end