# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Creating a fake user 🙋".yellow

user = User.create!(
	email: Faker::Internet.safe_email,
	first_name: Faker::Name.first_name,
	last_name: Faker::Name.last_name,
  username: Faker::Internet.user_name,
	password: "Pass3word:",
	password_confirmation: "Pass3word:"
)

##################################################################
#                                                                #
# Create Posts                                                   #
#                                                                #
##################################################################

50.times do |current_number|
	user.posts << Post.create!(
		title: Faker::Hacker.say_something_smart,
		body: (current_number % 2) == 0 ? Faker::Lorem.paragraphs((8..32).to_a.sample).join("<br><br>") : Faker::Lorem.sentences((16..64).to_a.sample).join(" ")
	)

	print "❤️"; print " "
end

##################################################################
#                                                                #
# DONE! 			                                                   #
#                                                                #
##################################################################
puts ""
puts "💖  #{Faker::Company.bs}  💖 ".magenta_on_white
puts ""
