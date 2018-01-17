require 'faker'
FactoryGirl.define do
  factory :transaction do
    number { Faker::Number.number(3) }
    category 'deposit'
    amount { Faker::Number.number(2) }
    account_id { FactoryGirl.create(:account).id }
  end
end
