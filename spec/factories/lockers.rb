FactoryGirl.define do
  factory :locker do
    section 'CA'
    number { Faker::Number.number(1) }
  end
end
