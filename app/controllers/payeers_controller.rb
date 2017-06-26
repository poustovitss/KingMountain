class PayeersController < ApplicationController
  def new 
    @payeer = Payeer.new
  end

  def create
    @payeer = Payeer.new(payeer_params)
    @payeer.save
  end

  private 

  def payeer_params
    params.require(:payeer).permit(:description, :currency, :total, :user_id)
  end 
end
