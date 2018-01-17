require 'faker'
FactoryGirl.define do
  factory :account do
    number { Faker::Number.number(2) }
    balance { Faker::Number.number(4) }
    user_id { FactoryGirl.create(:user).id }
    locker_id { FactoryGirl.create(:locker).id }
  end
end
