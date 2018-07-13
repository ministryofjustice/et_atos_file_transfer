require 'rails_helper'
RSpec.describe 'Upload file', type: :request do
  context 'with valid username and password' do
    include_context 'with valid login'
    let(:default_headers) do
      {
          'Authorization' => auth_header_value
      }
    end

    it 'just absorbs the request - does nothing apart from returns a 200' do
      # Act - call the endpoint
      post "/atos_api/v1/filetransfer/upload",
           params: { filename: 'whoknows' },
           headers: default_headers

      # Assert - make sure we respond correctly
      expect(response).to have_http_status(:ok)
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

    it 'returns a 404' do
      # Act - call the endpoint
      post "/atos_api/v1/filetransfer/upload",
           params: { filename: 'whoknows' },
           headers: default_headers

      # Assert - make sure we respond correctly
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'without authorization header' do
    include_context 'without error rescue'
    let(:default_headers) { {} }

    it 'returns a 404' do
      # Act - call the endpoint
      post "/atos_api/v1/filetransfer/upload",
           params: { filename: 'whoknows' },
           headers: default_headers

      # Assert - make sure we respond correctly
      expect(response).to have_http_status(:not_found)
    end
  end
end
