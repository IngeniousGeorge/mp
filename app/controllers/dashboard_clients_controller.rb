class DashboardClientsController < ApplicationController
  before_action :unauthorize_tempered_urls
  before_action :authenticate_client!
  load_and_authorize_resource :client, find_by: :slug

  def show
    @client = current_client
  end

  private

  def unauthorize_tempered_urls
    if params[:id] != current_client.slug
      redirect_to root_path, notice: "Invalid URL" 
    end
  end
  
  # def current_ability
  #   @current_ability ||= ::Ability.new(current_client)
  # end
end
