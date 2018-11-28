FactoryBot.define do
  factory :external_system, class: 'EtAtosFileTransfer::ExternalSystem' do
    sequence(:name) {|n| "name#{n}"}
    sequence(:reference) {|n| "reference#{n}"}
    enabled true

    trait :atos do
      name "atos"
      reference "atos"
      configurations do
        [
          build(:external_system_configuration, key: 'username', value: 'atos'),
          build(:external_system_configuration, key: 'password', value: 'password')
        ]
      end
    end

    trait :atos_secondary do
      name "atos secondary"
      reference "atos_secondary"
      configurations do
        [
          build(:external_system_configuration, key: 'username', value: 'atos_secondary'),
          build(:external_system_configuration, key: 'password', value: 'password')
        ]
      end
    end
  end
end
