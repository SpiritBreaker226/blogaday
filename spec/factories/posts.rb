FactoryGirl.define do
  factory :post do
    title Faker::Hacker.say_something_smart
		body  Faker::Lorem.paragraph((1..5).to_a.sample, true)
		user
  end
end
