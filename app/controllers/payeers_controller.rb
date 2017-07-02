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

    m_shop = '371275495'
    m_orderid = '2'
    m_amount = "100.00"
    m_cur = "RUB"
    m_desc = Base64.encode64('Text')
    m_key = "vksruu0m5qf49bqs"

    arr_hash = [m_shop, m_orderid, m_amount, m_cur, m_desc, m_key]

    arr_params = {
      success_url: 'https://king-mountain.pro/payeer/success',
      fail_url:    'https://king-mountain.pro/payeer/fail',
      status_url:  'https://king-mountain.pro/payeer/success'
    }

    # Твой ключ для шифрования дополнительных параметров.
    key_encrypt_parametres = 'vksruu0m5qf49bqs'

    key = Digest::MD5.hexdigest("#{key_encrypt_parametres}#{m_orderid}")

    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    cipher.key = key
    # Шифруем доп. параметры
    encrypted = URI::encode(Base64.encode64((cipher.update(arr_hash.to_json) + cipher.final)))

    # Добавляем параметры в массив для формирования подписи
    arr_hash << encrypted
    # Добавляем в массив для формирования подписи секретный ключ
    arr_hash << key
    # Формируем подпись
    include @sign = Digest::SHA256.digest(arr_hash.join(':')).upcase!
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
