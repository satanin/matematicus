require 'rails_helper'
require 'faker'

RSpec.describe Question, type: :model do

  it "must have a title" do
  	question = build(:question, title: nil)
  	expect(question.save).to be(false)
  end

  it "title lenght cannot exceed 300 characters" do
  	question = build(:question, title: Faker::Lorem.characters(301))
  	expect(question.save).to be(false)
  end

  it "must have a body" do
  	question = build(:question, body: nil)
  	expect(question.save).to be(false)
  end

  it "must initialize times_viewed field with zero" do
  	question = Question.new(title: "hola mundo", body: "1+1=2?")
  	question.save
  	expect(question.times_viewed).to be(0)
  end

  it "must belong to a user" do
  	question = Question.new(title: "hola mundo", body: "1+1=2?", user_id: nil)
  	expect(question.save).to be(false)
  end

end
