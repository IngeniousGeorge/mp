class DashboardClientsController < ApplicationController
  before_action :authenticate_client!
  before_action :unauthorize_tempered_urls
  load_and_authorize_resource :client, find_by: :slug

  def show
    @client = current_client
    @basket = @client.basket
    @locations = @client.locations
  end

  private

  def unauthorize_tempered_urls
    if params[:id] != current_client.slug
      redirect_to root_path, notice: "Invalid URL" 
    end
  end
  
  def current_ability
    @current_ability ||= ::Ability.new(current_client)
  end
end
