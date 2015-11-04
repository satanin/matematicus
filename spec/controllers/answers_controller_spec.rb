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

  context "When user is logged in" do
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

    context "GET #new" do

      it "returns http success" do
        get :new, user_id: user.id, question_id: question.id

        expect(response.status).to eq(200)
      end

      it "can access new answer form" do
        get :new, user_id: user.id, question_id: question.id

        expect(response).to render_template(:new)
        expect(assigns(:question)).to eq question
        expect(assigns(:answer)).to be_a_new Answer
      end

    end

    context "POST #create" do

      it "returns http redirection" do
        post :create, question_id: question.id, answer: { body: "This is the new body", user_id: user.id }

        expect(response.status).to be 302
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it "persists the new answer" do
        post :create, question_id: question.id, answer: { body: "This is the new body", user_id: user.id }

        expect(assigns(:user).answers.count).to eq 1
        expect(assigns(:answer).body).to eq "This is the new body"
      end

      context "When answer cannot be persisted" do

        it "returns http success" do
          post :create, question_id: question.id, answer: { body: nil, user_id: user.id }

          expect(response.status).to be 200
        end

        it "renders the new template" do
          post :create, question_id: question.id, answer: { body: nil, user_id: user.id }

          expect(response).to render_template "new"
          expect(assigns(:answer).errors.size).to_not be 0
        end
      end

    end

    context "PUT #update" do

      it "redirects to question_path if answer is persisted" do
        put :update, question_id: question.id, id: existing_answer.id, answer: { body: "This is the new question body" }

        expect(response.status).to eq 302
        expect(response).to redirect_to question_path(question)
      end

      it "can edit an existing answer" do
        put :update, question_id: question.id, id: existing_answer.id, answer: { body: "This is the new question body" }

        expect(assigns(:answer).body).to eq "This is the new question body"
      end

      context "When answer cannot be updated" do

        it "renders the edit template" do
          put :update, question_id: question.id, id: existing_answer.id, answer: { body: nil }

          expect(response.status).to eq 200
          expect(response).to render_template "edit"
        end
      end
    end

  end
end
