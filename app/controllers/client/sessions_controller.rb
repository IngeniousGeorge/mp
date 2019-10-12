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
      if db_basket = client.basket && cookie_basket = Basket.find(cookies['basket_id'])
        db_basket.overwrite_lines(cookie_basket)
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
