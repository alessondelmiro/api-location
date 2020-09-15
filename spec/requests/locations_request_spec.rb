require 'rails_helper'

RSpec.describe "Locations", type: :request do
  let(:headers) do
    {
      'ACCEPT' => 'application/json'
    }
  end

  describe "POST /locations" do
    before do
      user = create(:user)
      post "/locations", :params => { :location => location_params }, headers: authenticated_header(user, headers)
    end

    context "when the params are valid" do
      let(:location_params) { attributes_for(:location) }

      it 'returns status code created' do
          expect(response).to have_http_status(:created)
      end

      it 'saves the location in the database' do
          expect(Location.find_by(name: location_params[:name])).not_to be_nil
      end

      it 'returns the json for created location' do
          expect(json_body[:name]).to eq(location_params[:name])
      end
    end

    context "when the params are invalid" do
      let(:location_params) { attributes_for(:location, name: nil) }

      it 'returns status code unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the json error for status' do
          expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe "GET /locations/:id" do
    before do
      @user = create(:user)
      @location = create(:location)
      get "/locations/#{@location.id}", headers: authenticated_header(@user, headers)
    end
    context 'when location exists' do
      it 'returns status http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the location' do
        expect(json_body[:name]).to eq(@location.name)
      end
    end

    context 'when location does not exist' do
      before do
        get "/locations/#{@location.id+1}", headers: authenticated_header(@user, headers)
      end
      it 'returns status http not found' do
          expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe "GET /locations" do
    context "valid request" do
      before do
        user = create(:user)
        create_list(:location, 1)
        get "/locations", headers: authenticated_header(user, headers)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "contains expected location attributes" do
        expect(json_body[0].keys).to match_array([:id, :name, :description, :user, :address])
      end

      it 'returns the locations' do
        expect(json_body.size).to eq(1)
      end
    end

    context "invalid request" do
      before do
        get "/locations", headers: headers
      end
      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
