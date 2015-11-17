require 'rails_helper'

RSpec.describe Vote, type: :model do
	let(:user){create(:user)}
	let(:question){create(:question_with_answers)}
	let(:answer){create(:answer)}

	it "user can vote a question" do
		votes = Vote.all.count
		question_votes = question.votes.count
		Vote.create(user_id: user.id, question_id: question.id, value: 1)

		expect(Vote.all.count).to eq votes+1
		expect(question.votes.count).to eq question_votes+1
	end

	it "user can vote a answer" do
		votes = Vote.all.count
		answer_votes = answer.votes.count
		Vote.create(user_id: user.id, answer_id: answer.id, value: 1)

		expect(Vote.all.count).to eq votes+1
		expect(answer.votes.count).to eq answer_votes+1
	end

	it "dont let users vote twice the same question" do
		vote_one = Vote.create(question_id: question.id, user_id: user.id, value: 1)
		vote_two = Vote.create(question_id: question.id, user_id: user.id, value: 1)

		expect(vote_one.errors.count).to eq 0
		expect(vote_two.errors.count).to be > 0
	end

	it "dont let users vote twice the same answer" do
		vote_one = Vote.create(answer_id: answer.id, user_id: user.id, value: 1)
		vote_two = Vote.create(answer_id: answer.id, user_id: user.id, value: 1)

		expect(vote_one.errors.count).to eq 0
		expect(vote_two.errors.count).to be > 0
	end

	it "allow to users vote up questions" do
		votes_value = question.votes_value

		Vote.create(user_id: user.id, question_id: question.id, value: 1)

		expect(question.votes_value.to_i).to eq (votes_value.to_i+1)
	end

	it "allow to users vote down questions" do
		votes_value = question.votes_value

		Vote.create(user_id: user.id, question_id: question.id, value: -1)

		expect(question.votes_value.to_i).to eq votes_value.to_i-1
	end

	it "allow to users vote up answers" do
		votes_value = answer.votes_value

		Vote.create(user_id: user.id, answer_id: answer.id, value: 1)

		expect(answer.votes_value.to_i).to eq (votes_value.to_i+1)
	end

	it "allow to users vote down answers" do
		votes_value = answer.votes_value

		Vote.create(user_id: user.id, answer_id: answer.id, value: -1)

		expect(answer.votes_value.to_i).to eq votes_value.to_i-1
	end
end
