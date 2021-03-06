FactoryGirl.define do
  factory :post do
    title 	Faker::Hacker.say_something_smart
		body 		Faker::Lorem.characters
		summary Faker::Lorem.sentence
		publish_date { Faker::Time.between(5.days.ago, 5.days.from_now) }
		user

		factory :post_with_comments do
	  	transient do
	  		num_comments (3..5).to_a.sample
	  	end

	  	after(:create) do |post, transients|
	  		transients.num_comments.times { create(:comment, post: post) }
	  	end
	  end
  end
end
