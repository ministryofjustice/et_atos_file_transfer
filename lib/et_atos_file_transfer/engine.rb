module EtAtosFileTransfer
  class Engine < ::Rails::Engine
    isolate_namespace EtAtosFileTransfer
    config.generators.api_only = true
    config.et_atos_api = ::Rails::Application::Configuration::Custom.new
  end
end
