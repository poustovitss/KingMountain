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
    @user = current_user
    puts 'goooooooooooooooooooood'
    puts @order
    puts 'goooooooooooooooooooood'
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
  
  def pending
  end

  def fail
    flash[:balance] = 'Оплата не прошла :( Повторите попытку.'
    redirect_to profiles_path
  end

  private 

  def order_params
    params.require(:order).permit(:description, :currency, :total, :user_id)
  end 
end
