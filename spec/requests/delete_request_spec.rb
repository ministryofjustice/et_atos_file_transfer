require 'rails_helper'
RSpec.describe 'Delete an atos file', type: :request do
  context 'with valid username and password' do
    include_context 'with database config set'
    include_context 'with valid login for atos'
    let(:default_headers) do
      {
          'Authorization' => auth_header_value
      }
    end
    it 'deletes an existing file' do
      # Setup - create 2 files
      files = create_list(:exported_file, 2, :example_zip_file)

      # Act - delete the last one
      post "/delete",
           params: { filename: files.last.filename },
           headers: default_headers

      # Assert - verify that the correct file was deleted
      aggregate_failures 'Verify that the correct one was deleted and the other still exists' do
        expect(EtAtosFileTransfer::ExportedFile.count).to be 1
        expect(EtAtosFileTransfer::ExportedFile.first.filename).to eql files.first.filename
      end
    end

    it 'returns with 200' do
      # Setup - create 2 files
      files = create_list(:exported_file, 2, :example_zip_file)

      # Act - delete the last one
      post "/delete",
           params: { filename: files.last.filename },
           headers: default_headers

      # Assert - make sure we respond correctly
      expect(response).to have_http_status(:ok)
    end

    it 'return with 404 if the filename does not exist' do
      # Act - delete something that doesnt exists
      post "/delete",
           params: { filename: 'doesntexist' },
           headers: default_headers

      # Assert - make sure we respond correctly
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

    it 'returns with 404' do
      # Setup - create 2 files
      files = create_list(:exported_file, 2, :example_zip_file)

      # Act - delete the last one
      post "/delete",
           params: { filename: files.last.filename },
           headers: default_headers

      # Assert - make sure we respond correctly
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'without any authorization header' do
    include_context 'with database config set'
    include_context 'without error rescue'

    let(:default_headers) { {} }

    it 'returns with 404' do
      # Setup - create 2 files
      files = create_list(:exported_file, 2, :example_zip_file)

      # Act - delete the last one
      post "/delete",
           params: { filename: files.last.filename },
           headers: default_headers

      # Assert - make sure we respond correctly
      expect(response).to have_http_status(:not_found)
    end
  end

end
