class BasketsController < ApplicationController
  # before_action :authenticate_client!
  before_action :set_basket, only: [:edit, :update]

  # GET /baskets/1
  # GET /baskets/1.json
  def show
  end

  # GET /baskets/1/edit
  def edit
  end

  # PATCH/PUT /baskets/1
  # PATCH/PUT /baskets/1.json
  def update
    p @basket.inspect
    respond_to do |format|
      if @basket.change_product(basket_params["products"])
        format.html { redirect_back(fallback_location: root_path) }
        format.json { render :show, status: :ok, location: @basket }
      else
        format.html { render :edit }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

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
