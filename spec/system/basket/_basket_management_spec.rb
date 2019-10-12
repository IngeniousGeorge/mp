require "rails_helper"
require "helpers/basket_helper" #includes client_helper, product_helper

RSpec.describe "Seller - ", type: :feature do

  it "creates a new basket for first visitors" do
    visit root_path

    expect(Basket.count).to eq(1)
  end

  it "assigns the cookie basket to the client at sign up" do
    visit root_path
    cookie_basket_id = Basket.take.id
    sign_up_client

    expect(Client.take.basket.id).to eq(cookie_basket_id)
  end
  
  it "gathers products from cookie basket at sign in" do
    client = create(:client)

    visit root_path
    cookie_basket_id = Basket.take.id

    product = create_valid_product
    create(:basket_line, product_id: product.id, quantity: 1, basket_id: cookie_basket_id)

    sign_in_client

    expect(client.basket_lines.count).to eq(1)
    expect(client.basket_lines.first.product_id).to eq(product.id)
    expect(client.basket.id).to eq(cookie_basket_id)
    expect(BasketLine.count).to eq(1)
    expect(Basket.count).to eq(2)
  end

  # it "returns to cookie basket at log out" do
  #   sign_up_client
  #   log_out_client

  #   expect(Basket.count).to eq(2)
  # end

  
  it "adds to client basket when logged in" do
    # create a prod, client, save its basket_id, log in, add product, expect basket.lines.count to eq 1, and have prod id
    # product = create_valid_product
    # sign_up_client
    # log_out_client
    # sign_in_client
    # add_product
  end

  it "adds to cookie basket when logged out" do
    # create a prod, client, save its basket_id, log in, log out, add product, expect basket.lines.count to eq 0, and see prod id in another basket
  end
end



# it "retrieves basket from cookies if set"
# it "merges cookie basket with DB basket on sign up"
# it "merges cookie basket with DB basket on sign in"
# it "deletes cookie basket after merges"
# it "keeps same basket after log out"