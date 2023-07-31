FactoryBot.define do
  factory :group do
    space { 1 }
    name { "test name" }
    content { "test content" }

    trait :new_group do
      space { 2 }
      name { "new test name" }
      content { "new test content" }
    end

    trait :space_is_blank do
      space { nil }
    end

    trait :name_is_blank do
      name { nil }
    end

    trait :one_char_name do
      name { "1" }
    end

    trait :twenty_char_name do
      name { "12345678901234567890" }
    end

    trait :twenty_one_char_name do
      name { "123456789012345678901" }
    end

    trait :content_is_blank do
      content { nil }
    end

    trait :three_hundred_char_content do
      content do
        "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890" \
        "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890" \
        "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
      end
    end

    trait :three_hundred_one_char_content do
      content do
        "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890" \
        "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890" \
        "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890" \
        "1"
      end
    end
  end
end
