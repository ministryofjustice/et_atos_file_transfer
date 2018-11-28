module EtAtosFileTransfer
  class BasicConstraint
    def self.matches?(request)
      ::ActionController::HttpAuthentication::Basic.authenticate(request) do |username, password|
        system = ExternalSystem.atos_only.to_a.detect do |s|
          s.config_hash[:username] == username && s.config_hash[:password] == password
        end
        request.env['et_atos_file_transfer.external_system'] = system
        system.present?
      end
    end
  end
end
