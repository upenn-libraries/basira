# frozen_string_literal: true

RSpec.describe 'People API', type: :request do
  describe 'GET /api/people' do
    it 'returns people as JSON without authentication' do
      person = create(:person)

      get '/api/people', as: :json

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq('application/json')
      expect(response.parsed_body.to_s).to include(person.name)
    end
  end
end