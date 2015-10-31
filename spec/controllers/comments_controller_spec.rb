require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let (:question) { create(:question) }
  let (:user) { create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm
    sign_in user
  end

  context "when question has comments" do

    describe "GET #new" do
      it "returns http success" do
        get :new, question_id: question.id
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #create" do
      it "returns http success" do
        get :create, question_id: question.id
        expect(response).to have_http_status(:success)
      end
    end

  end

end
