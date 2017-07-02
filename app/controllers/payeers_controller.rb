class PayeersController < ApplicationController
  def new 
    @payeer = Payeer.new
  end

   def signcode
    require 'digest'
    require 'openssl'
    require 'json'
    require 'base64'
    require 'open-uri'
    @payeer = Payeer.new

    m_shop    = ENV['ID_MERCHANT']
    m_orderid = @payeer.id
    m_amount  = @payeer.total.to_f
    m_cur     = 'RUB'
    m_desc    = @payeer.description

    arr_hash = [m_shop, m_orderid, m_amount, m_cur, m_desc]

    arr_params = {
      success_url: 'https://domain.com/new_success_url',
      fail_url:    'https://domain.com/new_fail_url',
      status_url:  'https://domain.com/new_status_url'
    }

    # Твой ключ для шифрования дополнительных параметров.
    key_encrypt_parametres = '1321213weqeweqwqew321dzcSDASdq3ewqeQEQWeqd'

    key = Digest::MD5.hexdigest("#{key_encrypt_parametres}#{m_orderid}")

    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    cipher.key = key
    # Шифруем доп. параметры
    encrypted = URI::encode(Base64.encode64((cipher.update(arr_params.to_json) + cipher.final)))

    # Добавляем параметры в массив для формирования подписи
    arr_hash << encrypted
    # Добавляем в массив для формирования подписи секретный ключ
    arr_hash << key
    # Формируем подпись
    sign = Digest::SHA256.digest(arr_hash.join(':')).upcase!

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
