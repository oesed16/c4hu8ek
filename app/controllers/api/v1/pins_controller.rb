class Api::V1::PinsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_token

  def index
    render json: Pin.all.order('created_at DESC')
  end

  def create
    pin = Pin.new(pin_params)
    if pin.save
      render json: pin, status: 201
    else
      render json: { errors: pin.errors }, status: 401
    end
  end

  private
    def pin_params
      params.require(:pin).permit(:title, :image_url)
    end
    
    def authenticate_token
      authenticate_or_request_with_http_token do |token, options|
          User.find_by(api_token: token)
      end
    end

end