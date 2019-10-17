require "rails_helper"
require "helpers/product_helper"

RSpec.describe "FriendlyId - " do

  context "clients - " do

    before { create(:client, name: "joe", email: "joe@mp.com") }

    it "gives unique slugs to clients" do
      stripped_email = create(:client, name: "joe", email: "joes_stripped_email@mp.com")
      combination = create(:client, name: "joe", email: "joe@other.com")
      uuid = create(:client, name: "joe", email: "joe@another.com")

      expect(stripped_email.slug).to eq("joes_stripped_email")
      expect(combination.slug).to eq("joe-joe")
      expect(uuid.slug).to match(/^joe-.*/)
    end

  end

  context "sellers - " do

    it "makes sure seller slugs are unique" do
      create(:seller, slug: "same")
      
      expect { create(:seller, name: "other", slug: "same", email: "other@mp.com") }.to raise_error(/duplicate key value/)
    end

  end

  context "products - " do

    it "gives unique slugs to products based on seller slug" do
      prod = create_valid_product

      expect(prod.slug).to eq("product-name-seller-name")
    end

  end

  context "locations - " do
      
    it "gives scoped slugs to locations" do
      client_loc = create(:location)
      seller_loc = create(:location, :for_seller)

      expect(client_loc.slug).to eq("location-name")
      expect(Client.friendly.find("client-location").locations.friendly.find("location-name").recipient).to eq("Client Recipient")
      expect(seller_loc.slug).to eq("location-name")
      expect(Seller.friendly.find("seller-location").locations.friendly.find("location-name").recipient).to eq("Seller Recipient")
    end

  end

end