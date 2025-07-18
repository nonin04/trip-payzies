require 'net/http'

class Api::ExchangeRatesController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  before_action :authenticated_secret_key!

  
  def fetch
    ExchangeRateFetcher.call
    head :ok
  end

  private

  def authenticated_secret_key!
    unless params[:secret_key] == ENV['RATE_FETCH_SECRET_KEY']
      head :unauthorized
      return
    end
  end

end
