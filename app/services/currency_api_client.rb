require "json"

class CurrencyApiClient
  def self.latest(base:, codes:)
    fx = Currencyapi::Endpoints.new(apikey: ENV["FREECURRENCY_API_KEY"])
    response = fx.latest(base, codes)
    JSON.parse(response.body)
  end
end
