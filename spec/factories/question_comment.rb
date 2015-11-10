require 'faker'

FactoryGirl.define do
  factory :question_comment do
    body Faker::Lorem.characters(300)
    question
    user
  end
end