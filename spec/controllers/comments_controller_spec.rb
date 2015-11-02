require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let (:user) { FactoryGirl.create(:user_with_questions, questions_count: 15) }
  let (:user_commenting) { FactoryGirl.create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user_commenting.confirm
    sign_in user_commenting
  end

  context "when question has comments" do

    describe "GET #new" do
      xit "returns http success" do
        get :create, id: user.questions.first
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #create" do
      xit "returns http success" do
        post :create, id: comment.id
        expect(response).to have_http_status(:success)
      end
    end

  end

end
