# spec/requests/items_spec.rb
require 'rails_helper'

RSpec.describe 'Channels API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:provider) { create(:provider, created_by: user.id) }
  let!(:channels) { create_list(:channel, 20, provider_id: provider.id) }
  let(:provider_id) { provider.id }
  let(:id) { channels.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /providers/:provider_id/channels
  describe 'GET /providers/:provider_id/channels' do
    before { get "/providers/#{provider_id}/channels", params: {}, headers: headers }

    context 'when providers exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all providers channels' do
        expect(json.size).to eq(20)
      end
    end

    context 'when provider does not exist' do
      let(:provider_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Provider/)
      end
    end
  end

  # Test suite for GET /providers/:provider_id/channels/:id
  describe 'GET /providers/:provider_id/channels/:id' do
    before { get "/providers/#{provider_id}/channels/#{id}", params: {}, headers: headers }

    context 'when provider channel exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the channel' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when provider channel does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Channel/)
      end
    end
  end

  # Test suite for POST /providers/:provider_id/channels
  describe 'POST /providers/:provider_id/channels' do
    let(:valid_attributes) do 
      { name: 'Visit Narnia', url: 'https://narnia.com' }.to_json
    end

    context 'when request attributes are valid' do
      before do
        post "/providers/#{provider_id}/channels", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before do
        post "/providers/#{provider_id}/channels", params: {}, headers: headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /providers/:provider_id/channels/:id
  describe 'PUT /providers/:provider_id/channels/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do
      put "/providers/#{provider_id}/channels/#{id}", params: valid_attributes, headers: headers
    end

    context 'when channel exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the channel' do
        updated_channel = Channel.find(id)
        expect(updated_channel.name).to match(/Mozart/)
      end
    end

    context 'when the channel does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Channel/)
      end
    end
  end

  # Test suite for DELETE /providers/:provider_id/channels/:id
  describe 'DELETE /providers/:provider_id/channels/:id' do
    before do
      delete "/providers/#{provider_id}/channels/#{id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end