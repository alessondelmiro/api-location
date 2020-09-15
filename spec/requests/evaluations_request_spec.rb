require 'rails_helper'

RSpec.describe "Evaluations", type: :request do
  let(:headers) do
    {
      'ACCEPT' => 'application/json'
    }
  end

  describe "POST /evaluations" do
    before do
      user = create(:user)
      @location = create(:location)
      post "/evaluations", :params => { :evaluation => evaluation_params }, headers: authenticated_header(user, headers)
    end

    context "when the params are valid" do
      let(:evaluation_params) { attributes_for(:evaluation, location_id: @location.id) }

      it 'returns status code created' do
          expect(response).to have_http_status(:created)
      end

      it 'saves the evaluation in the database' do
          expect(Evaluation.find_by(rating: evaluation_params[:rating], comment: evaluation_params[:comment])).not_to be_nil
      end
    end

    context "when the params are invalid" do
      let(:evaluation_params) { attributes_for(:evaluation, rating: nil) }

      it 'returns status code unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the json error for status' do
          expect(json_body[:errors]).to have_key(:rating)
      end
    end
  end
end
