# frozen_string_literal: true

FactoryBot.define do
  factory :artwork_title do
    association :artwork
    sequence(:title) { |number| "Artwork #{number}" }
    primary { false }

    trait :primary do
      primary { true }
    end
  end
end