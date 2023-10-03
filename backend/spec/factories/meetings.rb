FactoryBot.define do
  factory :meeting do
    name { "test name" }
    priority { 1 }
    start_at { "2023-09-26 10:00:00" }
    end_at { "2023-09-26 11:00:00" }
    notice_period { true }
    content { "test content" }

    trait :new_meeting do
      name { "new name" }
      priority { 2 }
      start_at { "2023-09-27 12:00:00" }
      end_at { "2023-09-27 13:00:00" }
      notice_period { false }
      content { "new test content" }
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
      name { 123456789012345678901 }
    end

    trait :priority_is_blank do
      priority { nil }
    end

    trait :priority_is_string do
      priority { "test" }
    end

    trait :priority_is_0 do
      priority { 0 }
    end

    trait :priority_is_3 do
      priority { 3 }
    end

    trait :priority_is_4 do
      priority { 4 }
    end

    trait :start_at_is_blank do
      start_at { nil }
    end

    trait :start_at_is_string do
      start_at { "test" }
    end

    trait :end_at_is_blank do
      end_at { nil }
    end

    trait :end_at_is_string do
      end_at { "test" }
    end

    trait :start_at_equal_end_at do
      end_at { "2023-09-26 10:00:00" }
    end

    trait :start_at_is_greater_than_end_at do
      end_at { "2023-09-26 09:00:00" }
    end

    trait :notice_period_is_blank do
      notice_period { nil }
    end

    trait :notice_period_is_string do
      notice_period { "test" }
    end

    trait :notice_period_is_false do
      notice_period { false }
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
