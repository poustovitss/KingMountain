class GetmoneysController < ApplicationController
  def new 
    @getmoney = Getmoney.new
  end

  def create
    vivod = Transfer.find_by_user_id(current_user.id)
    @getmoney = Getmoney.new(getmoney_params)
    
    unless vivod.nil?
      if @getmoney.total >= 50
        if vivod.summa >= @getmoney.total
          @getmoney.save

          user = Transfer.find_by_user_id(current_user.id)
          user.summa = user.summa - @getmoney.total
          user.save
          flash[:balance] = 'Ваш запрос на вывод средств скоро будет обработан!'
        else
          flash[:balance] = 'У вас не достаточно средств'
        end
      else
        flash[:balance] = 'Минимальная сумма вывода 50рублей'
      end
    else
      flash[:balance] = 'У вас не достаточно средств'
    end
    redirect_to profiles_path
  end

  private 

  def getmoney_params
    params.require(:getmoney).permit(:desc, :status, :total, :wallet, :walletfirm, :user_id)
  end 
end
