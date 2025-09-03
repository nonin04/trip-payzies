# require "json"

# class ExchangeRateFetcherSample
#   def self.call
#     begin

#       currencies = Currency.all
#       codes_str = currencies.map { |c| c.code }.join(",")

#       fx = Currencyapi::Endpoints.new(apikey: ENV["FREECURRENCY_API_KEY"])
#       response = fx.latest("JPY", codes_str)
#       # jsonからハッシュに変換
#       json = JSON.parse(response.body)
#       data = json["data"]

#       datetime_str = json["meta"]["last_updated_at"]
#       date = Date.parse(datetime_str)

#       data.each do |code, rate|
#         Rails.logger.info(code)
#         Rails.logger.info(rate["value"])
#         currency = Currency.find_by(code: code)
#         next unless currency

#         ExchangeRate.find_or_create_by(
#           currency_id: currency.id,
#           rate_date: date
#         ) do |exchange_rate|
#           exchange_rate.rate = rate["value"]
#         end
#         Rails.logger.info("#{code}:#{date}時点の為替レートを保存しました。")
#       end

#     rescue JSON::ParserError => e
#       Rails.logger.error("JSON変換エラー: #{e.message}")
#     rescue ActiveRecord::RecordInvalid => e
#       Rails.logger.error("DBバリデーションエラー: #{e.message}")
#     rescue StandardError => e
#       Rails.logger.error("Unexpected error: #{e.message}")
#       raise
#     end
#   end
# end
