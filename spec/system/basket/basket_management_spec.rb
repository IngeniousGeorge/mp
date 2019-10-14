require "rails_helper"
require "helpers/basket_helper" #includes client_helper, product_helper

# Basket management summary

# at first visit -> create new basket, save id in cookie (app_controller / set_basket)
# at sign up -> create new basket, assign to client, gather prods from cookie basket (client/registration_controller)
# at sign in -> retrieve client basket, gather prods from cookie basket (client/sessions_controller)
# at log out -> recreates a new basket and assigns id to cookie (client/sessions_controller)
# after log out -> should use the cookie basket
# when visiting pages -> app_controller assign client basket if logged in, else the cookie basket (basket model via app_controller)
# when adding products -> use @current_basket, (client if logged in, else cookie)
# methods can't be extracted to basket class because of heavy use of cookies method, only available in controllers

RSpec.describe "Basket - ", type: :feature do

  it "creates a new basket for first visitors" do
    visit root_path
    expect(Basket.count).to eq(1)
  end

  it "assigns a new basket to the client at sign up" do
    # we create a first visit basket then sign up
    visit root_path
    cookie_basket_id = last_created_basket.id
    sign_up_client
    # we should have 2 disctinct baskets
    expect(last_created_client.basket.id).not_to be_nil
    expect(last_created_client.basket.id).not_to eq(cookie_basket_id)
    expect(Basket.count).to eq(2)
  end

  it "creates a new cookie basket after log out" do
    # we create first visit basket, a client basket, and another basket after log out
    visit root_path
    sign_up_client
    log_out_client
    visit root_path
    # we should have 3 disctinct baskets
    expect(Basket.count).to eq(3)
  end

  it "gathers products from cookie basket at sign up" do
    # we create a first visit baseket
    visit root_path
    cookie_basket_id = last_created_basket.id
    # we add a line to this basket
    product = create_valid_product
    create(:basket_line, product_id: product.id, quantity: 1, basket_id: cookie_basket_id)
    # we sign up client
    sign_up_client
    client = last_created_client
    # we expect both baskets to have a line with the product
    expect(client.basket_lines.count).to eq(1)
    expect(client.basket_lines.first.product_id).to eq(product.id)
    expect(client.basket.id).not_to eq(cookie_basket_id)
    expect(BasketLine.count).to eq(2)
    expect(Basket.count).to eq(2)
  end

  it "gathers products from cookie basket at sign in" do
    # we create a client
    sign_up_client
    client = last_created_client
    log_out_client
    # we recreate a basket at log out and add a line to it
    visit root_path
    cookie_basket_id = last_created_basket.id
    product = create_valid_product
    create(:basket_line, product_id: product.id, quantity: 1, basket_id: cookie_basket_id)
    # we sign in client
    sign_in_client
    # we expect both client and cookie basket to have a line with product
    expect(client.basket_lines.count).to eq(1)
    expect(client.basket_lines.first.product_id).to eq(product.id)
    expect(client.basket.id).not_to eq(cookie_basket_id)
    expect(BasketLine.count).to eq(2)
    expect(Basket.count).to eq(3)
  end

  it "uses client basket after sign in" do
    # we create a client and log out
    sign_up_client
    client = last_created_client
    log_out_client
    #we create a product to add later
    product = create_valid_product
    # we log in client and add product twice
    sign_in_client
    add_product_to_basket
    add_product_to_basket
    # we expect client basket to have 1 line with a quantity of 2
    expect(client.basket_lines.count).to eq(1) 
    expect(client.basket_lines.first.quantity).to eq(2) 
    expect(client.basket_lines.first.product_id).to eq(product.id) 
  end

  it "uses cookie basket after log out" do
    # we create a client and log out
    sign_up_client
    log_out_client
    cookie_basket = last_created_basket
    #we create a product to add later
    product = create_valid_product
    # we add product twice
    add_product_to_basket
    add_product_to_basket
    # we expect client basket to have 1 line with a quantity of 2
    expect(cookie_basket.lines.count).to eq(1) 
    expect(cookie_basket.lines.first.quantity).to eq(2) 
    expect(cookie_basket.lines.first.product_id).to eq(product.id) 
  end
end
