require 'rails_helper'

RSpec.describe "Evaluations", type: :request do
  let(:headers) do
    {
      'ACCEPT' => 'application/json'
    }
  end

  # describe "POST /evaluations" do
  #   before do
  #     user = create(:user)
  #     @location = create(:location)
  #     post "/evaluations", :params => { :evaluation => evaluation_params }, headers: authenticated_header(user, headers)
  #   end

  #   context "when the params are valid" do
  #     let(:evaluation_params) { attributes_for(:evaluation, location_id: @location.id) }

  #     it 'returns status code created' do
  #         expect(response).to have_http_status(:created)
  #     end

  #     it 'saves the evaluation in the database' do
  #         expect(Evaluation.find_by(rating: evaluation_params[:rating], comment: evaluation_params[:comment])).not_to be_nil
  #     end
  #   end

  #   context "when the params are invalid" do
  #     let(:evaluation_params) { attributes_for(:evaluation, rating: nil) }

  #     it 'returns status code unprocessable_entity' do
  #         expect(response).to have_http_status(:unprocessable_entity)
  #     end

  #     it 'returns the json error for status' do
  #         expect(json_body[:errors]).to have_key(:rating)
  #     end
  #   end
  # end

  describe "GET /evaluations" do
    before do
      @location = create(:location)
      @user = create(:user)
      create_list(:evaluation, 12, location_id: @location.id)
    end
    context "valid request" do
      before do
        get "/evaluations", params: { location_id: @location.id }, headers: authenticated_header(@user, headers)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "contains expected evaluation attributes" do
        expect(json_body[0].keys).to match_array([:id, :rating, :comment, :created_at, :user])
      end

      it 'returns the evaluations' do
        expect(json_body.size).to eq(10)
      end

      it 'does paginate records for second page' do
        get "/evaluations", params: { location_id: @location.id, page: 2 }, headers: authenticated_header(@user, headers)
        expect(json_body.size).to eq(2)
        expect(Evaluation.count).to eq(12)
      end

      it 'returns the quantity of items defined by limit' do
        get "/evaluations", params: { location_id: @location.id, limit: 3 }, headers: authenticated_header(@user, headers)
        expect(json_body.size).to eq(3)
      end
    end

    context "invalid request" do
      before do
        get "/evaluations", headers: authenticated_header(@user, headers)
      end
      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
