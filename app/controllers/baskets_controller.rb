class BasketsController < ApplicationController
  # before_action :authenticate_client!
  before_action :set_basket, only: :show
  before_action :prepare_order, only: :show

  def show
    @lines = @basket.basket_lines
  end

  private

    def set_basket
      if current_client
        @basket = current_client.basket
      elsif cookies['basket_id']
        @basket = Basket.find(cookies['basket_id'])
      else
        @basket = Basket.create
        cookies['basket_id'] = @basket.id
      end
    end

    # def set_basket
    #   if params[:client_id]
    #     @basket = Client.friendly.find(params[:client_id]).basket
    #   else
    #     @basket = Basket.find(cookies['basket_id'])
    #   end
    # end

    def basket_params
      params.require(:basket).permit(:products, :client_id)
    end

    def prepare_order
      if current_client
        @order = Order.new(client_id: @basket.client.id, amount: @basket.set_amount)
      else
        @order = Order.new(amount: @basket.set_amount)
      end
    end
end
