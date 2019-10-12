# frozen_string_literal: true

class Client::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in !!! replace Basket.find with more robust method
  def create
    super do |client|
      # duplicate cookie basket lines to client basket
      cookie_basket = Basket.find(cookies['basket_id'])
      basket = client.basket || Basket.new(client_id: client.id)
      basket.duplicate_lines(cookie_basket)
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super do |client|
      new_basket = Basket.create!
      cookies['basket_id'] = new_basket.id
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
