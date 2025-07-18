class Api::ExchangeRatesController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  require 'net/http'
  
  def fetch
    if params[:secret] == ENV['EXCHANGE_RATE_SECRET']
      FetchExchangeRate.call
    end
  end

  def Fetch

end
