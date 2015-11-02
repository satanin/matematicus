  #validates :user_id, presence: true
  #validates :question_id, presence: true
  #validates :body, presence: true

require 'rails_helper'
require 'faker'

RSpec.describe Answer, type: :model do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  it "must have a body" do
    answer = build(:answer, body: nil)
    expect(answer.save).to be(false)
  end

  it "can be persisted with user and question" do
    expect(question.save).to be(true)
  end

  it "must belong to a user" do
    answer = Answer.new(body: "1+1=2?", user_id: nil, question_id: question.id )
    expect(answer.save).to be(false)
  end

  it "must belong to a question" do
    answer = Answer.new(body: "1+1=2?", user_id: user.id, question_id: nil )
    expect(answer.save).to be(false)
  end

  it "must be a Post child"  do
    answer = Answer.new
    expect(answer.class.superclass.to_s).to eq "Post"
  end

end
