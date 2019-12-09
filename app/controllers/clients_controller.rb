class ClientsController < ApplicationController
  before_action :set_client, only: [:update]
  before_action :authenticate_client!

  def edit
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_dashboard_path(@client), notice: 'client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render client_dashboard_path(@client), alert: 'client wasn\'t successfully updated.' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private 

  def set_client
    @client = Client.friendly.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :email, :password, :slug)
  end
end
