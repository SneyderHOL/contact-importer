FactoryBot.define do
  factory :import_file do
    status { "on hold" }
    user { nil }
    after (:build) do |import_file|
      import_file.file.attach(io: File.open(Rails.root.join('tmp', 'storage', 'testing_file.csv')),
      filename: 'testing_file.csv', content_type: 'text/csv')
    end
  end
end
