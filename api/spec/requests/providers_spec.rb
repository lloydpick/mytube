require 'rails_helper'

RSpec.describe 'Providers API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:providers) { create_list(:provider, 10, created_by: user.id) }
  let(:provider_id) { providers.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /providers
  describe 'GET /providers' do
    # make HTTP get request before each example
    before { get '/providers', params: {}, headers: headers }

    it 'returns providers' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /providers/:id
  describe 'GET /providers/:id' do
    before { get "/providers/#{provider_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the providers' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(provider_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:provider_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Provider/)
      end
    end
  end

  # Test suite for POST /providers
  describe 'POST /providers' do
    let(:valid_attributes) do
      # send json payload
      { name: 'Vimeo', url: 'https://vimeo.com', created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/providers', params: valid_attributes, headers: headers }

      it 'creates a provider' do
        expect(json['name']).to eq('Vimeo')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { name: '' }.to_json }
      before { post '/providers', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /providers/:id
  describe 'PUT /providers/:id' do
    let(:valid_attributes) { { name: 'Rename' }.to_json }

    context 'when the record exists' do
      before { put "/providers/#{provider_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /providers/:id
  describe 'DELETE /providers/:id' do
    before { delete "/providers/#{provider_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end