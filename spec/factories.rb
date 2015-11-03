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

# This will guess the User class
FactoryGirl.define do
  factory :user do
    #username Faker::Name.name
    #email Faker::Internet.email
    username
    email
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

FactoryGirl.define do
  factory :post do
    title "MyText"
	body "MyText"
	times_viewed 1
	type ""
	user
  end
end

FactoryGirl.define do
  factory :question do
  	title Faker::Name.title
  	body Faker::Lorem.characters(300)
  	times_viewed Faker::Number.between(1, 1000)
  	user_id Faker::Number.between(1, 1000)
  	user
  end
end

FactoryGirl.define do
  factory :comment do
  	type "Comment"
  	body Faker::Lorem.characters(300)
  	question
  	user
  end
end

FactoryGirl.define do
  factory :answer do
  	type "Answer"
  	body Faker::Lorem.characters(300)
  	question
  	user
  end
end
