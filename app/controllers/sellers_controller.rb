class SellersController < ApplicationController
  before_action :set_seller, only: [:show]
  before_action :authenticate_seller!, only: [:edit, :update]
  load_and_authorize_resource :seller, find_by: :slug

  def index
  end

  def show
  end

  def edit
    @seller = current_seller
  end

  def update
  end

  private

  def set_seller
    @seller = Seller.friendly.find(params[:id])
  end

  def current_ability
    @current_ability ||= ::Ability.new(current_seller)
  end
end
