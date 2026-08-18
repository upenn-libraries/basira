# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    sequence(:name) { |number| "Person #{number}" }
    display_name { name }
    person_type { 'Person' }
  end
end