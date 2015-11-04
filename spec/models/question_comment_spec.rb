  # validates :user_id, presence: true
  # validates :body, presence: true


require 'rails_helper'
require 'faker'

RSpec.describe QuestionComment, type: :model do
  let(:comment) { create(:question_comment) }
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  it "must have a body" do
    comment = build(:question_comment, body: nil)
    expect(comment.save).to be(false)
  end

  it "can be persisted with user and question" do
    expect(comment.save).to be(true)
  end

  it "must belong to a user" do
    comment = QuestionComment.new( body: "1+1=2?", user_id: nil, question_id: question.id )
    expect(comment.save).to be(false)
  end

  it "must belong to a question" do
    comment = QuestionComment.new( body: "1+1=2?", user_id: user.id, question_id: nil)
    expect(comment.save).to be(false)
  end

end