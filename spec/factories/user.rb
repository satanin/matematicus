require 'faker'

FactoryGirl.define do
  sequence :username do |n|
    Faker::Name.name
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end
end

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password Faker::Internet.password(8)
    factory :user_with_questions do
      transient do
        questions_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:question, evaluator.questions_count, user: user)
      end
    end
    factory :user_with_answers do
      transient do
        answers_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:answer, evaluator.answers_count, user: user)
      end
    end
  end
end