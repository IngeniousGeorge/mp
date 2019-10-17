require "rails_helper"

RSpec.describe "Basket oprations - " do

  let(:line) { build_stubbed(:basket_line, quantity: 5) }

  it "adds quantity" do
    line.add_to_line(1)

    expect(line.quantity).to eq(6)
  end

  it "adds quantity when negative" do
    line.add_to_line(-2)

    expect(line.quantity).to eq(3)
  end

  it "sets absolute quantity" do
    line.set_absolute_value(8)

    expect(line.quantity).to eq(8)
  end
end