class ExchangeRateFetcher
  def self.call
    codes_str = Currency.all.map(&:code).join(",")

    begin
      data = CurrencyApiClient.latest(base: "JPY", codes: codes_str)
      ExchangeRateUpdater.update_from_api(data)
    rescue StandardError => e
      Rails.logger.error("為替レート取得/保存中にエラー: #{e.message}")
      raise
    end
  end
end
