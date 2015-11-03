  # validates :user_id, presence: true
  # validates :body, presence: true


require 'rails_helper'
require 'faker'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  it "must have a body" do
    comment = build(:comment, body: nil)
    expect(comment.save).to be(false)
  end

  it "can be persisted with user and question" do
    expect(comment.save).to be(true)
  end

  it "must belong to a user" do
    comment = Comment.new( body: "1+1=2?", user_id: nil, question_id: question.id )
    expect(comment.save).to be(false)
  end

  it "must belong to a question or an answer" do
    comment = Comment.new( body: "1+1=2?", user_id: user.id, question_id: nil, answer_id: nil )
    expect(comment.save).to be(false)
  end

  it "must be a Post child"  do
    comment = Comment.new
    expect(comment.class.superclass.to_s).to eq "Post"
  end

end