class OrdersController < ApplicationController

  def create
    respond_to do |format|
      if Clerk.proceed_order(current_client, current_client.basket)
        format.html do
          redirect_to client_dashboard_path(current_client), notice: "Order was successfully placed."
        end
        format.json { render :show, status: :created, location: order }
      else
        format.html { redirect_to basket_path(current_client.basket), alert: "There was a problem with the order." }
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end
  end
end