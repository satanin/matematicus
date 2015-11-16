require 'faker'

FactoryGirl.define do
  factory :question do
  	title Faker::Name.title
  	body Faker::Lorem.characters(300)
  	times_viewed Faker::Number.between(1, 1000)
  	user
    tags {[FactoryGirl.create(:tag)]}
    factory :question_with_tags do
      transient do
        tags_count 5
      end

      after(:create) do |question, evaluator|
        create_list(:tag, evaluator.tags_count, question: question)
      end
    end
    factory :question_with_votes do
      transient do
        votes_count 5
      end

      after(:create) do |question, evaluator|
        create_list(:vote, evaluator.votes_count, question: question)
      end
    end
    factory :question_with_answers do
      transient do
        answers_count 5
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question)
      end
    end
  end
end