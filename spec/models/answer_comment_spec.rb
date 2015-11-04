  # validates :user_id, presence: true
  # validates :body, presence: true


require 'rails_helper'
require 'faker'

RSpec.describe AnswerComment, type: :model do
  let(:comment) { create(:answer_comment) }
  let(:answer) { create(:answer) }
  let(:user) { create(:user) }

  it "must have a body" do
    comment = build(:answer_comment, body: nil)
    expect(comment.save).to be(false)
  end

  it "can be persisted with user and question" do
    comment = build(:answer_comment)
    expect(comment.save).to be(true)
  end

  it "must belong to a user" do
    comment = AnswerComment.new( body: "1+1=2?", user_id: nil, answer_id: answer.id )
    expect(comment.save).to be(false)
  end

  it "must belong to a question or an answer" do
    comment = AnswerComment.new( body: "1+1=2?", user_id: user.id, answer_id: nil )
    expect(comment.save).to be(false)
  end

end