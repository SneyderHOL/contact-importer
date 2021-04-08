FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "username#{n}@example.com" }
    password { "password" }
  end
end
