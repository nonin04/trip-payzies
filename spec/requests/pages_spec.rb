require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /term" do
    it "利用規約が正常に表示される" do
      get terms_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /privacy" do
    it "プライバシーポリシーが正常に表示される" do
      get privacy_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /info" do
    it "アプリ情報が正常に表示される" do
      get info_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /faq" do
    it "Q&Aが正常に表示される" do
      get faq_path
      expect(response).to have_http_status(200)
    end
  end
end
