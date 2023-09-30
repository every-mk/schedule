FactoryBot.define do
  factory :invite do
    kind { 1 }

    trait :new_invite do
      kind { 2 }
    end

    trait :kind_is_blank do
      kind { nil }
    end

    trait :kind_is_string do
      kind { "test" }
    end

    trait :kind_is_0 do
      kind { 0 }
    end

    trait :kind_is_3 do
      kind { 3 }
    end

    trait :kind_is_4 do
      kind { 4 }
    end
  end
end
