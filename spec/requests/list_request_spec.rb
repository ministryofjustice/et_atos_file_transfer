require 'rails_helper'
RSpec.describe 'List all atos files', type: :request do
  context 'with valid username and password' do
    include_context 'with database config set'
    include_context 'with valid login for atos'
    let(:default_headers) do
      {
          'Authorization' => auth_header_value
      }
    end
    it 'lists 2 files' do
      files = create_list(:exported_file, 2, :example_zip_file)
      get '/list', headers: default_headers
      expect(response.body.lines.map {|l| l.gsub(/\n$/, '')}).to eql files.map(&:filename)
    end

    it 'returns a 200 status code' do
      create_list(:exported_file, 2, :example_zip_file)
      get '/list', headers: default_headers
      expect(response).to have_http_status(:ok)
    end
  end

  context 'with invalid username and password' do
    include_context 'with database config set'
    include_context 'with invalid login'
    include_context 'without error rescue'
    let(:default_headers) do
      {
          'Authorization' => auth_header_value
      }
    end
    it 'returns a 404' do
      create_list(:exported_file, 2, :example_zip_file)
      get '/list', headers: default_headers
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'without any authorization header' do
    include_context 'with database config set'
    include_context 'without error rescue'
    it 'returns a 404' do
      create_list(:exported_file, 2, :example_zip_file)
      get '/list'
      expect(response).to have_http_status(:not_found)
    end
  end
end
