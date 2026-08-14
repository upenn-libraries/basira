# frozen_string_literal: true

# spec/support/auth_helpers.rb
module AuthHelpers
  def auth_headers_for(user)
    user.create_new_auth_token
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request
end