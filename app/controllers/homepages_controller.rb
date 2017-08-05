class HomepagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :service, :contact]

  def index
  end

  def show
  end

  def service

  end

  def contact

  end
end
