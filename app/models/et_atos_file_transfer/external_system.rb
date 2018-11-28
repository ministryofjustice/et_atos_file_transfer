module EtAtosFileTransfer
  class ExternalSystem < ApplicationRecord
    self.table_name = :external_systems

    has_many :configurations, class_name: '::EtAtosFileTransfer::ExternalSystemConfiguration'
    scope :atos_only, -> { where(reference: ['atos', 'atos_secondary'])}

    def config_hash
      @config_hash = configurations.inject({}) do |acc, config|
        acc[config.key.to_sym] = config.value
        acc
      end
    end
  end
end
