# curencyAPIを叩いて為替レートを取得し、保存するサービスクラス(orchestration layer))
class ExchangeRateOrchestrator
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
