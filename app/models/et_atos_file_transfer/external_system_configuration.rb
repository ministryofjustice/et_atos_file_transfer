module EtAtosFileTransfer
  class ExternalSystemConfiguration < ApplicationRecord
    self.table_name = :external_system_configurations
    belongs_to :external_system
  end
end
