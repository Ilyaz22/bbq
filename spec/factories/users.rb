FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "email#{n}@yandex.ru" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end
