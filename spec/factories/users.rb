require 'faker'
FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.phone_no { Faker::Number.number(10) }
    f.email { Faker::Internet.email }
    f.aadhar_no { Faker::Number.number(12) }
  end

  factory :invalid_user, parent: :user do |f|
    f.name nil
  end
end
