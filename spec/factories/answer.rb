require 'faker'

FactoryGirl.define do
  factory :answer do
  	body Faker::Lorem.characters(300)
  	question
  	user
  end
end