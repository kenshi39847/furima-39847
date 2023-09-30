FactoryBot.define do
  factory :purchase_address do
    post_code { '123-4567' }
    prefecture_id { 1 }
    municipalities { '東京都' }
    street { '青山1-1' }
    building { '東京ハイツ' }
    telephone_number { 12345678912 }
  end
end