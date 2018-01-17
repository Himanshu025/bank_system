FactoryGirl.define do
  factory :loan do
    category 'Personal'
    amount Faker::Number.number(4)
    no_of_years { Faker::Number.number(1) }
    account_id { FactoryGirl.create(:account).id }
  end
end
