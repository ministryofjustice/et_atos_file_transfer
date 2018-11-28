module EtAtosFileTransfer
  class BasicConstraint
    def self.matches?(request)
      ::ActionController::HttpAuthentication::Basic.authenticate(request) do |username, password|
        ExternalSystem.atos_only.to_a.any? do |s|
          s.config_hash[:username] == username && s.config_hash[:password] == password
        end
      end
    end
  end
end
