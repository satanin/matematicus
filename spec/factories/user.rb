require 'faker'

# This will guess the User class
FactoryGirl.define do
  factory :user do
    username Faker::Name.name
    email Faker::Internet.email
    password Faker::Internet.password(8)
    factory :user_with_questions do
      transient do
        questions_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:question, evaluator.questions_count, user: user)
      end
    end
  end
end