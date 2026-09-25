# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    association :artwork
    association :visual_context
  end
end