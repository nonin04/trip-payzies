class ExchangeRateUpdater
  def self.update_from_api(data)
    date = Date.parse(data["meta"]["last_updated_at"])

    data["data"].each do |code, rate|
      Rails.logger.info(code)
      Rails.logger.info(rate["value"])
      currency = Currency.find_by(code: code)
      next unless currency

      ExchangeRate.find_or_create_by(
        currency_id: currency.id,
        rate_date: date
      ) do |exchange_rate|
        exchange_rate.rate = rate["value"]
      end
      Rails.logger.info("#{code}:#{date}時点の為替レートを保存しました。")
    end
  end
end
