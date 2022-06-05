class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
   @total = 0
   @order = Order.new(order_params)
   if params[:_add] == "usersAdd"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name
   elsif params[:_add] == "currentAdd"
        @address = Adress.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
   elsif params[:_add] == "newAdd"
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
   else
        render :new
   end
   @cart_items = current_customer.cart_items.all
   @order.customer_id = current_customer.id
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_details = @order.order_details.new
        @order_details.item_id = cart_item.item.id
        @order_details.price = cart_item.item.price
        @order_details.amount = cart_item.amount
        @order_details.save
        @cart_items.destroy_all
      end
    redirect_to thanks_order_path
  end

  def index
    @orders = current_customer.orders
    @items = Item.all
  end

  def show
    @total = 0
    @order = Order.find(params[:id])
    @cart_items = current_customer.cart_items.all
  end

  private

  def order_params
     params.require(:order).permit(:payment_method,:postal_code,:address,:name,:total_payment)
  end


end
