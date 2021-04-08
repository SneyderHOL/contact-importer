FactoryBot.define do
  factory :contact do
    name { "MyString" }
    birthdate { "MyString" }
    phone { "MyString" }
    address { "MyString" }
    credit_card { "MyString" }
    franchise { "MyString" }
    email { "MyString" }
    user { nil }
  end
end
