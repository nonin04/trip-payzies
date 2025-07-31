FactoryBot.define do
  factory :group do
    association :user
    name {"テストグループ"}
    icon {Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/nonin2.png"), "image/png")}
  end
end