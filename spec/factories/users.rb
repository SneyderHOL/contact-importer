FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "username#{n}@example.com" } #email { "username@example.com" }
    password { "password" }
  end
end
