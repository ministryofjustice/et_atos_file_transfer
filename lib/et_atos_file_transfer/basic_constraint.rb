module EtAtosFileTransfer
  class BasicConstraint
    def self.matches?(request)
      ::ActionController::HttpAuthentication::Basic.authenticate(request) do |username, password|
        username == Rails.configuration.et_atos_api.username &&
          password == Rails.configuration.et_atos_api.password
      end
    end
  end
end
