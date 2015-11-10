require 'rails_helper'
require 'faker'

RSpec.describe QuestionsController, type: :controller do

	context "When User is not logged in" do

    describe "When GET#index accesed" do

  		it "redirects to login" do
        get :index, user_id: "1"
        expect(response).to redirect_to(new_user_session_path)
  		end

    end

  end

  context "When user is logged id" do
    let(:user) { create(:user_with_questions, questions_count: 15) }
    let(:another_user) { create(:user_with_questions, questions_count: 20)}
    let(:question) { build(:question) }
    let(:new_question) { create(:question)}
    let(:tag) { create(:tag)}

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm
      another_user.confirm
      sign_in user
    end

    describe "GET #index" do

      it "responds with http sucess" do
        get :index

        expect(response.status).to eq(200)
        expect(response).to be_success
      end

      it "can access to his questions" do
        get :index

        expect(response).to render_template(:index)
        expect(assigns(:questions).count).to be 15
      end

    end

    describe "GET #new" do

      it "responds with http success" do
        get :new

        expect(response.status).to eq(200)
        expect(response).to be_success
      end

      it "can access new question form" do
        get :new

        expect(response).to render_template(:new)
        expect(assigns(:question)).to be_a_new Question
      end

    end

    describe "POST #create" do

      describe "when is persisted" do
        it "responds with http redirection" do
          post :create, question: { title: question.title, body: question.body, user_id: user.id, tag_ids: [ tag.id ] }

          expect(response.status).to be 302
        end

        it "can create new questions" do
          post :create, question: { title: question.title, body: question.body, user_id: user.id, tag_ids: [ tag.id ] }

          expect(user.questions.count).to eq 16
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      describe "when is not persisted" do
        it "responds with http success" do
          post :create, question: { title: nil, body: question.body, user_id: user.id }

          expect(response.status).to be 200
        end

        it "cannot create new question" do
          post :create, question: { title: nil, body: question.body, user_id: user.id }

          expect(assigns(:question).errors.size).to_not be 0
        end
      end
    end

    describe "GET #edit" do

      it "responds with http success" do
        get :edit , id: new_question.id

        expect(response.status).to eq 200
      end

    end

    describe "PUT #update" do

      describe "when is persisted" do
        it "responds with http redirection" do
          put :update, id: new_question.id, question: { title: "This is the new question title", body: "This is the new question body" }

          expect(response.status).to eq 302
        end

        it "can edit an existing question" do
          put :update, id: new_question.id, question: { title: "This is the new question title", body: "This is the new question body" }

          expect(response).to redirect_to question_path(new_question)
          expect(assigns(:question).title).to eq "This is the new question title"
          expect(assigns(:question).body).to eq "This is the new question body"
        end
      end

      describe "when is not persisted" do
        it "responds with http success" do
          put :update, id: new_question.id, question: { title: nil, body: "This is the new question body" }

          expect(response.status).to eq 200
          expect(response).to render_template 'edit'
        end

        it "can not edit an existing question" do
          put :update, id: new_question.id, question: { title: nil, body: "This is the new question body" }

          expect(assigns(:question).errors.size).to_not be 0
        end
      end
    end
  end

end
