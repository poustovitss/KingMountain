class OrdersController < ApplicationController
  def index
  end

  def show
    # @order = Order.find(params[:id])
  end

  def new 
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.save
  end

  def success
    @order = Order.find(params[:id])
    @order.user.balance += @order.total
    @order.user.save
  end
  
  def update
  end


  def pending
  end

  def fail
  end

  private 

  def order_params
    params.require(:order).permit(:description, :currency, :total, :user_id)
  end 
end
