class BasketsController < ApplicationController
  before_action :authenticate_client!
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
    respond_to do |format|
      if @basket.update(basket_params)
        format.html { redirect_to @basket, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @basket }
      else
        format.html { render :edit }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basket
      @basket = Client.friendly.find(params[:client_id]).basket
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def basket_params
      params.require(:basket).permit(:products, :client_id)
    end
end
