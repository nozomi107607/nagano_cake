class Admin::OrdersController < ApplicationController

  def show
    @total = 0
    @order = Order.find(params[:id])
    @item = @order.order_details
  end

  def order_params
     params.require(:order).permit(:payment_method,:postal_code,:address,:name,:total_payment)
  end


end
