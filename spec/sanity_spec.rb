# frozen_string_literal: true

# Minimal spec with no Rails/database dependency. Run `bundle exec rspec spec/sanity_spec.rb`
# to confirm RSpec itself is wired up correctly.
#
# 🤖 AI Usage Disclosure: Written by Claude (Anthropic).
RSpec.describe 'RSpec configuration' do
  it 'runs a basic example' do
    expect(1 + 1).to eq(2)
  end
end
