FactoryBot.define do
  factory :external_system_configuration, class: 'EtAtosFileTransfer::ExternalSystemConfiguration' do
    sequence(:key) {|n| "key#{n}"}
    sequence(:value) {|n| "value#{n}"}
  end
end
