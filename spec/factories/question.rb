require 'faker'

# This will guess the User class
FactoryGirl.define do
  factory :question do
	title Faker::Name.title
	body Faker::Lorem.characters(300)
	times_viewed Faker::Number.between(1, 1000)
	association :user_id, factory: :user, strategy: :build
  end
end