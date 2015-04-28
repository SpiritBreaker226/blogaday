FactoryGirl.define do
  factory :user do
  	user_new_password = "Pass3word:"

    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    username   { Faker::Internet.user_name }
    email      { Faker::Internet.free_email }
    password   { user_new_password }
    password_confirmation { user_new_password }

  	factory :user_with_posts do
	  	transient do
	  		num_posts 3
	  	end

	  	after(:create) do |user, transients|
	  		transients.num_posts.times { create(:post, user: user) }
	  	end
	  end
  end
end
