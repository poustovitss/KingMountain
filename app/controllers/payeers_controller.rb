class PayeersController < ApplicationController
  def new 
    @payeer = Payeer.new
  end

  def signcode

  end
    

  def create
    @payeer = Payeer.new(payeer_params)
    
    signcode

    @payeer.save
  end

  def success
    @payeer = Payeer.find(params[:m_status])
    if (params["m_status"] =="success")
      if ref_balance.nil?
        transfer = Transfer.new
        transfer.user_id = current_user.id
        transfer.bank_id = Bank.last.id
        transfer.summa = @payeer.total
        transfer.save
      else
        ref_balance.summa += @payeer.total
        ref_balance.save
      end
      flash[:balance] = "Вы пополнили счет на сумму #{@payeer.total}"
      
      redirect_to profiles_path
    else
      flash[:balance] = 'Оплата не прошла :('
      redirect_to profiles_path
    end
  end

  def fail
    @payeer = Payeer.find(params[:ik_pm_no])

    if (params["m_status"] =="fail")
      flash[:balance] = 'Оплата не прошла :('
    end
      redirect_to profiles_path
  end

  private 

  def payeer_params
    params.require(:payeer).permit(:description, :currency, :total, :user_id)
  end 
end
