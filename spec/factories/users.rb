FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name { "Arron" }
    last_name { "Sumner" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
  end
end
