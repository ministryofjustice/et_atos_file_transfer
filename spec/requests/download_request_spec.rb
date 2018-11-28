require 'rails_helper'
RSpec.describe 'Download an atos zip file', type: :request do
  context 'with valid username and password' do
    include_context 'with database config set'
    include_context 'with valid login for atos'
    let(:default_headers) do
      {
          'Authorization' => auth_header_value
      }
    end

    it 'downloads a file' do
      # Arrange - Setup a zip file for downloading
      file_path = File.absolute_path(File.join('..', 'fixtures', 'example_zip_file.zip') ,__dir__)
      zip_file = create(:exported_file, :example_zip_file, file_path: file_path)

      # Act - Download it
      get "/download/#{zip_file.filename}", headers: default_headers

      # Assert - Check the response - we base64 encode both sides to make comparison easier
      expect(Base64.encode64(response.body)).to eql Base64.encode64(File.read(file_path))
    end

    it 'returns a 200' do
      # Arrange - Setup a zip file for downloading
      file_path = File.absolute_path(File.join('..', 'fixtures', 'example_zip_file.zip') ,__dir__)
      zip_file = create(:exported_file, :example_zip_file, file_path: file_path)

      # Act - Download it
      get "/download/#{zip_file.filename}", headers: default_headers

      # Assert - Check the response status
      expect(response).to have_http_status(:ok)
    end

    it 'returns a 404 if a file is not found' do
      # Act - Download wrong filename
      get "/download/can-be-anything", headers: default_headers

      # Assert - Check the response is a 404
      expect(response).to have_http_status(:not_found)
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
    it 'responds with a head 404' do
      # Arrange - Setup a zip file for downloading
      file_path = File.absolute_path(File.join('..', 'fixtures', 'example_zip_file.zip') ,__dir__)
      zip_file = create(:exported_file, :example_zip_file, file_path: file_path)

      # Act - Try and download a file
      get "/download/#{zip_file.filename}", headers: default_headers

      # Assert - Check the response is a 404
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'without any authorization header' do
    include_context 'with database config set'
    include_context 'without error rescue'
    let(:default_headers) { {} }
    it 'responds with a head 404' do
      # Arrange - Setup a zip file for downloading
      file_path = File.absolute_path(File.join('..', 'fixtures', 'example_zip_file.zip') ,__dir__)
      zip_file = create(:exported_file, :example_zip_file, file_path: file_path)

      # Act - Try and download a file
      get "/download/#{zip_file.filename}", headers: default_headers

      # Assert - Check the response is a 404
      expect(response).to have_http_status(:not_found)
    end
  end

end
