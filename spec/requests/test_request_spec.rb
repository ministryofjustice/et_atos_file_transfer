require 'rails_helper'
RSpec.describe 'Test request endpoint', type: :request do
  context 'with valid username and password' do
    include_context 'with valid login'
    let(:default_headers) do
      {
          'Authorization' => auth_header_value
      }
    end
    it 'responds with a head 200' do
      get '/atos_api/v1/filetransfer/test', headers: default_headers do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context 'with invalid username and password' do
    include_context 'with invalid login'
    include_context 'without error rescue'
    let(:default_headers) do
      {
          'Authorization' => auth_header_value
      }
    end
    it 'responds with a head 404' do
      get '/atos_api/v1/filetransfer/test', headers: default_headers
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'without any authorization header' do
    include_context 'without error rescue'
    it 'responds with a head 404' do
      get '/atos_api/v1/filetransfer/test'
      expect(response).to have_http_status(:not_found)
    end
  end
end
