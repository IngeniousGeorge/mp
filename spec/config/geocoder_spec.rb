require "rails_helper"

RSpec.describe "Geocoder - location" do

  let(:loc) { create(:location) }

  it "receives coordinates on create" do
    expect(loc.latitude).to be_a(Float)
    expect(loc.longitude).to be_a(Float)
  end

end