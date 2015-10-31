require 'faker'

# This will guess the User class
FactoryGirl.define do
  factory :question do
  	title Faker::Name.title
  	body Faker::Lorem.characters(300)
  	times_viewed Faker::Number.between(1, 1000)
  	user
  end
end
