require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:question) { create(:question) }

  context "when user is not logged in" do

    describe "GET #vote_up" do

      it "redirects to log in" do
        xhr :get, :vote_up, question_id: question.id, format: :js

        expect(response.status).to be 401
      end
    end
  end

  context "when user is logged in" do
    let(:user) { create(:user_with_questions, questions_count: 15) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm
      sign_in user
    end

    describe "GET #vote_up" do

      it "increases vote value by 1" do
        xhr :get, :vote_up, question_id: question.id, format: :js

        expect(response.status).to eq 200
        expect(question.votes_value).to eq "1"
        expect(response).to render_template("update_votes")
      end
    end

    describe "GET #vote_down" do

      it "decreases vote value by 1" do
        xhr :get, :vote_down, question_id: question.id, format: :js

        expect(response.status).to eq 200
        expect(question.votes_value).to eq "-1"
        expect(response).to render_template("update_votes")
      end
    end
  end
end
