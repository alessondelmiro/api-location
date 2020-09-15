require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:headers) do
    {
      'ACCEPT' => 'application/json'
    }
  end

  describe "POST /signup" do
    before do
      post "/signup", params: { user: user_params }, headers: headers
    end

    context "when the params are valid" do
      let(:user_params) { attributes_for(:user, address: attributes_for(:address)) }

      it 'returns status code created' do
          expect(response).to have_http_status(:created)
      end

      it 'saves the user in the database' do
          expect(User.find_by(email: user_params[:email])).not_to be_nil
      end

      it 'returns the json for created user' do
          expect(json_body[:email]).to eq(user_params[:email])
      end
    end

    context "when the params are invalid" do
      let(:user_params) { attributes_for(:user, email: nil) }

      it 'returns status code unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the json error for status' do
          expect(json_body[:errors]).to have_key(:email)
      end
    end
  end
  
  describe "GET /profile" do
    context "valid request" do
      before do
        @user = create(:user)
        get "/profile", headers: authenticated_header(@user, headers)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it 'returns the user' do
        expect(json_body[:name]).to eq(@user.name)
      end
    end

    context "invalid request" do
      before do
        get "/profile", headers: headers
      end
      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

end
