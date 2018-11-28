RSpec.shared_context 'with valid login for atos' do
  let(:auth_header_value) do
    config = external_system_atos.configurations.inject({}) do |acc, rec|
      acc[rec.key.to_sym] = rec.value
      acc
    end
    email = config[:username]
    password = config[:password]
    ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
  end
end
