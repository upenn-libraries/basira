# frozen_string_literal: true

RSpec.describe 'Artworks API', type: :request do
  describe 'GET /api/artworks/:id' do
    it 'returns an artwork as JSON without authentication' do
      artwork = create(:artwork, :published, :with_primary_title)

      get "/api/artworks/#{artwork.id}", as: :json

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq('application/json')

      body = response.parsed_body

      expect(body).to include('artwork')
      expect(body.dig('artwork', 'id')).to eq(artwork.id)
    end

    it 'rejects an unauthenticated artwork index request' do
      get '/api/artworks', as: :json

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns the artwork collection to an authenticated user' do
      user = create(:user)
      artwork = create(:artwork, :with_primary_title)

      get '/api/artworks',
        headers: user.create_new_auth_token,
        as: :json

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.to_s).to include(artwork.id.to_s)
    end
  end

  describe 'POST /api/artworks' do

    let(:image) do
      fixture_file_upload(
        Rails.root.join('spec/fixtures/files/test-image.jpg'),
        'image/jpeg'
      )
    end

    let(:params) do
      {
        artwork: {
          published: false,
          height: 200,
          width: 200,
          attachments_attributes: [
            {
              file: image,
              primary: true
            }
          ],
          artwork_titles_attributes: [
            {
              title: 'Image smoke test',
              primary: true
            }
          ]
        }
      }
    end

    it 'creates an artwork for an authenticated user' do
      user = create(:user)

      expect do
        post '/api/artworks',
          params: params,
          headers: user.create_new_auth_token
      end.to change(Artwork, :count).by(1)
      expect(response).to have_http_status(:ok)

      artwork = Artwork.order(:id).last
      expect(artwork.primary_attachment.file).to be_attached
      expect(artwork.created_by_id).to eq(user.id)
      expect(artwork.updated_by_id).to eq(user.id)
    end
  end
end