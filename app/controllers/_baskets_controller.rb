class BasketsController < ApplicationController
  # before_action :authenticate_client!
  before_action :set_basket, only: :edit

  # def edit
  #   @lines = @basket.basket_lines
  # end

  private

    def set_basket
      if params[:client_id]
        @basket = Client.friendly.find(params[:client_id]).basket
      else
        @basket = Basket.find(cookies['basket_id'])
      end
    end

    def basket_params
      params.require(:basket).permit(:products, :client_id)
    end
end
