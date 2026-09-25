# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |number| "user-#{number}@example.com" }
    password { 'password123' }
    password_confirmation { password }

    trait :admin do
      admin { true }
    end
  end
end