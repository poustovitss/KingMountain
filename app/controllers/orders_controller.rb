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
    @order = Order.last
<<<<<<< HEAD
    @user = current_user
     
=======
    @user = User.find(params[:id])
>>>>>>> b57d38dec35f145b2c491f1ee593364e7aff1b8b
    if @user.id == @order.user.id

      @order.user.balance += @order.total
      @order.user.save
      flash[:balance] = 'Оплата прошла заебись'
      
      redirect_to profiles_path
    else
      flash[:balance] = 'Оплата не прошла :('
      redirect_to profiles_path
    end
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
