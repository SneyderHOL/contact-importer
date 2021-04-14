FactoryBot.define do
  factory :failed_register do
    error { "MyText" }
    import_file { nil }
  end
end
