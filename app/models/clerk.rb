class Clerk

  def self.proceed_order(client, basket)
    #create order from basket
    #create order_lines from basket_lines
    #create sales from order_lines

    Clerk.transaction do
      order = Order.new(client_id: client.id, amount: basket.prepare_amount).save
      order_lines = []
      sales = {}

      basket.basket_lines.each do |line|

        seller_id = line.product.seller.id

        order_line = OrderLine.new(
          order_id: order.id,
          client_id: client.id,
          seller_id: seller_id,
          product_id: line.product.id,
          quantity: line.quantity,
          amount: line.line_amout
        ).save
        order_lines << order_line

        if sales[seller_id]
          sales[seller_id].order_lines << order_line
          sales[seller_id].update!
        else
          sales[seller_id] = Sale.new(
            seller_id: seller_id,
            order_id: order.id,
            order_lines: [order_line]
          ).save
        end
      end
    end
  end
end

    # transaction
    # true -> calculate sales amount, return true
    # false -> delete order, return false

    # order_sales = []
    # seller_products = {}
    # order_sellers.each do |seller|
    #   order_sales << OrderSale.new(order_id: order.id, seller_id: )
      
    #   seller_products.each do |product|
    #     order_products << OrderProduct.new(order_id: order.id, )
    #   end
    # end