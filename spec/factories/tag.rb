require 'faker'

FactoryGirl.define do
  factory :tag do
    name Faker::Hacker.noun
    description Faker::Lorem.characters(300)
  end
end