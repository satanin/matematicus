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
  end
end