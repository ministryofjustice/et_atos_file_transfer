RSpec.shared_context 'with invalid login' do
  let(:auth_header_value) do
    email = Rails.configuration.et_atos_api.username
    password = "completelywrongpassword"
    ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
  end
end
