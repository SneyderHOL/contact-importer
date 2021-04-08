FactoryBot.define do
  factory :import_file do
    status { "on hold" }
    user { nil }
    after (:build) do |import_file|
      import_file.file.attach(io: File.open(Rails.root.join('tmp', 'storage', 'users-2021-03-26.csv')),
      filename: 'users-2021-03-26.csv', content_type: 'text/csv')
    end
  end
end
