require 'faker'

FactoryGirl.define do
  factory :answer_comment do
    body Faker::Lorem.characters(300)
    answer
    user
  end
end