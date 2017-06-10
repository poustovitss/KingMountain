class GetbalancesController < ApplicationController
  def new 
    @getbalance = Getbalance.new
  end

  def create
    if current_user.level >= 3  
      if current_user.balance > 150
        @getbalance = Getbalance.new(getbalance_params)

        user = current_user
        if current_user.aerodrome == false
          percent = @getbalance.total * 50 / 100
        else
          percent = @getbalance.total * 30 / 100
        end

        @getbalance.total = @getbalance.total - percent
        @getbalance.save

        user = current_user
        if current_user.aerodrome == false
          percent = @getbalance.total * 50 / 100
        else
          percent = @getbalance.total * 30 / 100
        end
        
        user.balance = 0
        user.save

        user.level = 0
        user.refferences.each do |refferences|
          refferences.reffered_by = 0
          refferences.save
        end
        user.save

        flash[:balance] = 'Ваш запрос на вывод средств скоро будет обработан!'
      else
        flash[:balance] = 'Что-бы вывести средства у вас должно быть не менее 150рублей'
      end
     else
      flash[:balance] = 'Вам требуется 3 уровень'
     end 
        redirect_to profiles_path
  end

  private 

  def getbalance_params
    params.require(:getbalance).permit(:desc, :status, :total, :wallet, :walletfirm, :user_id)
  end 
end
