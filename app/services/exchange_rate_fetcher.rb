require 'json'
class ExchangeRateFetcher
  def self.call
    puts ENV['FREECURRENCY_API_KEY']
    fx = Currencyapi::Endpoints.new(apikey: ENV['FREECURRENCY_API_KEY'])
    response = fx.latest("JPY", "EUR,USD")
    #jsonからハッシュに変換
    json = JSON.parse(response.body)
    data = json['data']

    rates.each do |code, rate|
      puts code
      puts rate["value"]
    end

  end
end