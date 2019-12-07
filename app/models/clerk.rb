class Clerk

  def self.proceed_order(client, basket)
    
    Order.transaction do
      
      #create order
      order = Order.new(client_id: client.id, amount: basket.prepare_amount)
      order.save!
      order_lines = []
      sales = {}
      
      #create order_lines from basket_lines
      basket.basket_lines.each do |line|
        
        seller_id = line.product.seller.id
        
        order_line = OrderLine.new(
          order_id: order.id,
          client_id: client.id,
          seller_id: seller_id,
          product_id: line.product.id,
          quantity: line.quantity,
          amount: line.line_amount
        )
        order_line.save!
        order_lines << order_line
        
        #create sales from order_lines
        if sales[seller_id]
          sales[seller_id].order_lines << order_line
          sales[seller_id].update!
        else
          sales[seller_id] = Sale.new(
            seller_id: seller_id,
            client_id: client.id,
            order_id: order.id,
            order_lines: [order_line]
          ).save!
        end
      end

      #add sale_id to order_lines
      order_lines.each do |line|
        sale_id = Sale.where(order_id: order.id, seller_id: line.seller_id).first.id
        line.update!(sale_id: sale_id)
      end

      #purge basket
      basket.basket_lines.each do |line|
        line.destroy!
      end
    end
  end
end