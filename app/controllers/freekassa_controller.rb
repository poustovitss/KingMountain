class FreekassaController < ApplicationController
  protect_from_forgery except: [:result]
  before_action :authenticate_user!

  def new
    @order = Payeer.new
  end

  def create
    @order = current_user.payeers.create(order_params)
    if @order.save

      redirect_to freekassa_confirm_path(@order)
    else
      redirect_to root_path
    end
  end

  def confirm
    @order = Payeer.find(params[:id])
    redirect_to root_path unless @order.user == current_user # && !@order.finished?
    @merchant_id = '50878'
    @secret_word = '4arp3nje'
    @order_id = @order.id.to_s
    @order_amount = @order.total.to_s
    @sign = Digest::MD5.hexdigest(@merchant_id + ':' + @order_amount + ':' + @secret_word + ':' + @order_id)
  end

  def result
    logger.debug params.inspect
    logger.debug '-*-*-*-*-*-*-*-*-*-*-*-'
    logger.debug params['SIGN']
    logger.debug params['AMOUNT']

    @merchant_id = '50878'
    @secret_word2 = '9155h78l'
    @params = request.params
    @amount = params['AMOUNT']
    @order_id = params['MERCHANT_ORDER_ID'].to_i
    @sign = params['SIGN']
    @order = Payeer.find(@order_id)
    @sample_sign = Digest::MD5.hexdigest("#{@merchant_id}:#{@order.total}:#{@secret_word2}:#{@order.id}")
    ref_balance = Transfer.find_by_user_id(@order.user.id)
    if @sign == @sample_sign
      if ref_balance.nil?
        transfer = Transfer.new
        transfer.user_id = current_user.id
        transfer.bank_id = Bank.last.id
        transfer.summa = @order.total
        transfer.save
      else
        ref_balance.summa += @order.total
        ref_balance.save
      end
      flash[:balance] = "Вы пополнили счет на сумму #{@order.total}"
    else
      redirect_to freekassa_fail_path
    end
  end

  def fail
  end

  private

  def order_params
    params.require(:payeer).permit(:total)
  end
end
