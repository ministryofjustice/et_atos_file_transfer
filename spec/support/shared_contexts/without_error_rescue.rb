RSpec.shared_context 'without error rescue' do
  around do |example|
    begin
      env_config = Rails.application.env_config
      original_show_exceptions = env_config['action_dispatch.show_exceptions']
      original_show_detailed_exceptions = env_config['action_dispatch.show_detailed_exceptions']
      env_config['action_dispatch.show_exceptions'] = true
      env_config['action_dispatch.show_detailed_exceptions'] = false
      example.run
    ensure
      env_config['action_dispatch.show_exceptions'] = original_show_exceptions
      env_config['action_dispatch.show_detailed_exceptions'] = original_show_detailed_exceptions
    end
  end
end
