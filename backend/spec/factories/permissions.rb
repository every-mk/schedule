FactoryBot.define do
  factory :permission do
    privilege { 1 }
    join { true }
    post { true }

    trait :new_permission do
      privilege { 2 }
      join { false }
      post { false }
    end

    trait :privilege_is_blank do
      privilege { nil }
    end

    trait :privilege_is_string do
      privilege { "test" }
    end

    trait :privilege_is_0 do
      privilege { 0 }
    end

    trait :privilege_is_3 do
      privilege { 3 }
    end

    trait :privilege_is_4 do
      privilege { 4 }
    end

    trait :join_is_blank do
      join { nil }
    end

    trait :join_is_string do
      join { "test" }
    end

    trait :join_is_false do
      join { false }
    end

    trait :post_is_blank do
      post { nil }
    end

    trait :post_is_string do
      post { "test" }
    end

    trait :post_is_false do
      post { false }
    end
  end
end
