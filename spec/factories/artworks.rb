# frozen_string_literal: true

FactoryBot.define do
  factory :artwork do
    published { false }

    trait :published do
      published { true }
    end

    trait :with_primary_title do
      after(:create) do |artwork|
        create(:artwork_title, artwork: artwork, primary: true)
      end
    end
  end
end