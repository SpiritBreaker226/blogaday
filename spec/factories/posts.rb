FactoryGirl.define do
  factory :post do
    title 	Faker::Hacker.say_something_smart
		body 		Faker::Lorem.characters
		summary Faker::Lorem.sentence
		user
  end
end
