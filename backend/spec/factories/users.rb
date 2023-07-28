FactoryBot.define do
  factory :user do
    name { "test#" }
    email { |n| "test#{n}@example.com" }
    password { "password" }
    confirmed_at { Date.today }

    trait :new_user do
      name { "test" }
      email { "test@example.com" }
    end

    trait :name_is_blank do
      name { nil }
    end

    trait :one_char_name do
      name { "1" }
    end

    trait :thirty_char_name do
      name { "123456789012345678901234567890" }
    end

    trait :thirty_one_char_name do
      name { "1234567890123456789012345678901" }
    end

    trait :email_is_blank do
      email { nil }
    end

    trait :password_is_blank do
      password { nil }
    end

    trait :not_confirmationed do
      confirmed_at { nil }
    end
  end
end
