require 'rails_helper'
require 'faker'

RSpec.describe QuestionsController, type: :controller do

	context "When User is not logged in" do
    describe "When GET#index accesed"

		it "redirects to login" do
      get :index, user_id: "1"
      expect(response).to redirect_to(new_user_session_path)
		end
  end

  context "When user is logged id" do
    let(:user) { create(:user_with_questions, questions_count: 15) }
    let(:another_user) { create(:user_with_questions, questions_count: 20)}
    let(:question) { build(:question) }


    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm
      another_user.confirm
      sign_in user
    end

    it "can access to his questions" do
      get :index, user_id: user.id

      expect(response.status).to eq(200)
      expect(response).to be_success
      expect(response).to render_template(:index)
      expect(assigns(:questions).count).to be 15
      expect(Question.all.count).to be 35
    end

    it "can access new question form" do
      get :new, user_id: user.id

      expect(response.status).to eq(200)
      expect(response).to be_success
      expect(response).to render_template(:new)
      expect(assigns(:question)).to be_a_new Question
    end

    it "can create new questions" do
      post :create, question: { title: question.title, body: question.body }

      expect(response.status).to be 302
      expect(Question.all.count).to eq 36
      expect(response).to redirect_to question_path(assigns(:question))
    end
  end

end
