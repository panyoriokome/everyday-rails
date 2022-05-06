FactoryBot.define do
  factory :user do
    first_name { "Arron" }
    last_name { "Sumner" }
    email { "tester@example.com" }
    password { "password" }
  end
end
