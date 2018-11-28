RSpec.shared_context 'with database config set' do
  let!(:external_system_atos) { create(:external_system, :atos) }
  let!(:external_system_atos_secondary) { create(:external_system, :atos_secondary) }
end
