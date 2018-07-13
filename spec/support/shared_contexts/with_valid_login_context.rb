RSpec.shared_context 'with valid login' do
  let(:auth_header_value) do
    email = Rails.configuration.et_atos_api.username
    password = Rails.configuration.et_atos_api.password
    ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
  end
end
