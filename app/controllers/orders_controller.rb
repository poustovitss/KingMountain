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
     @order = order_class.find(params['ik_pm_no'])
    if not @order
      logger.debug "Interkassa error: order not found"
      render text: 'Order not found', status: 500
    else
      flash[:balance] = 'Оплата прошла заебись'
      redirect_to profiles_path
    end
    # @order = Order.last
    # @user = current_user

  
    # if @user.id == @order.user.id

    #   @order.user.balance += @order.total
    #   @order.user.save
    #   flash[:balance] = 'Оплата прошла заебись'
      
    #   redirect_to profiles_path
    # else
    #   flash[:balance] = 'Оплата не прошла :('
    #   redirect_to profiles_path
    # end
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
