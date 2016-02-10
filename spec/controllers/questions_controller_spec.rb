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
    let(:user_questions_count) { 15 }
    let(:user) { create(:user_with_questions, questions_count: user_questions_count) }
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

    context "When supplied id is not valid" do
      it "redirects to root path if supplied id is not a valid id" do
        get :edit, id: 19999

        expect(response).to redirect_to root_path
      end
    end

    describe "GET #index" do

      it "responds with http sucess" do
        get :index

        expect(response.status).to eq(200)
      end

      it "can access to his questions" do
        get :index

        expect(response).to render_template(:index)
        expect(assigns(:questions).count).to be user_questions_count
      end

    end

    describe "GET #new" do

      it "responds with http success" do
        get :new

        expect(response.status).to eq(200)
      end

      it "can access new question form" do
        get :new

        expect(response).to render_template(:new)
        expect(assigns(:question)).to be_a_new Question
      end

    end

    describe "POST #create" do

      describe "when params are valid" do

        let(:question_params) { { title: question.title, body: question.body, user_id: user.id, tag_ids: [ tag.id ] } }
        it "responds with http redirection" do
          post :create, question: question_params

          expect(response.status).to be 302
        end

        it "redirects to question path" do
          post :create, question: question_params

          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      describe "when params are invalid" do
        it "responds with http success" do
          post :create, question: { title: nil }

          expect(response.status).to be 200
        end

        it "renders the new question template" do
          post :create, question: { title: "Hi", body: "Question", tag_ids: [] }

          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do

      it "responds with http success" do
        get :edit, id: new_question.id
        
        expect(response.status).to eq 200
      end
    end

    describe "PUT #update" do

      let(:question_body) { "This is the new question body" }
      
      describe "when params are valid" do
        let(:question_title) { "This is the new question title" }
        let(:question_params) { { title: question_title, body: question_body } }

        it "redirects to question path" do
          put :update, id: new_question.id, question: question_params

          expect(response).to redirect_to question_path(new_question)
        end
      end

      describe "when params are invalid" do
        it "responds with http success" do
          put :update, id: new_question.id, question: { title: nil, body: question_body }

          expect(response.status).to eq 200
          expect(response).to render_template 'edit'
        end
      end
    end

    describe "GET #tagged" do

      it "responds with http success" do
        get :tagged, name: tag.name

        expect(response.status).to eq 200
      end

      it "renders tagged template" do
        get :tagged, name: question.tags.first.name

        expect(response).to render_template(:tagged)
      end

      it "redirects to root path if tag name doesn't exist" do
        get :tagged, name: "pericodelospalotes"

        expect(response).to redirect_to root_path
      end
    end
  end

end
