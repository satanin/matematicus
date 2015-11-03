require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  context "When User is not logged in" do
    let(:question) { create(:question) }

    describe "When GET#new accesed" do

      it "redirects to login" do
        get :new, question_id: question.id
        expect(response).to redirect_to(new_user_session_path)
      end

    end
  end

  context "When user is logged id" do
    let(:user) { create(:user_with_questions, questions_count: 15) }
    let(:another_user) { create(:user_with_questions, questions_count: 20) }
    let(:user_answering)  { create(:user_with_answers, answers_count: 15) }
    let(:question) { create(:question) }
    let(:answer) { build(:answer) }
    let(:existing_answer) { create(:answer) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm
      another_user.confirm
      user_answering.confirm
      sign_in user
    end

    it "can access new answer form" do
      get :new, user_id: user.id, question_id: question.id

      expect(response.status).to eq(200)
      expect(response).to be_success
      expect(response).to render_template(:new)
      expect(assigns(:question)).to eq question
      expect(assigns(:answer)).to be_a_new Answer
    end

    it "can create new answers" do
      post :create, question_id: question.id, answer: { body: "This is the new body" }

      expect(response.status).to be 302
      expect(Answer.all.count).to eq 16
      expect(response).to redirect_to question_path(assigns(:question))
      expect(assigns(:answer).body).to eq "This is the new body"
    end

    it "can edit an existing answer" do
      put :update, question_id: question.id, id: existing_answer.id, answer: { body: "This is the new question body" }

      expect(response.status).to eq 302
      expect(response).to redirect_to question_path(question)
      expect(assigns(:answer).body).to eq "This is the new question body"
    end
  end
end
