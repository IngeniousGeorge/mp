class SellersController < ApplicationController
  before_action :set_seller, only: [:show, :update]
  before_action :authenticate_seller!, only: [:update]
  # load_and_authorize_resource :seller, find_by: :slug

  # def index
  # end

  def show
  end

  # def edit
  #   @seller = current_seller
  # end

  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to seller_dashboard_path(@seller), notice: 'Seller was successfully updated.' }
        format.json { render :show, status: :ok, location: @seller }
      else
        format.html { render seller_dashboard_path(@seller), alert: 'Seller wasn\'t successfully updated.' }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_seller
    @seller = Seller.friendly.find(params[:id])
  end

  def seller_params
    params.require(:seller).permit(:email, :password, :name, :slug, :description, :categories)
  end

  def current_ability
    @current_ability ||= ::Ability.new(current_seller)
  end
end
