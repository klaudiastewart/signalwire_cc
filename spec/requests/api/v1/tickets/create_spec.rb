require 'rails_helper'

RSpec.describe 'Create Tickets' do
  describe 'happy path' do
    it 'creates a ticket with correct params' do
      post '/api/v1/tickets', params: {ticket: {title: 'Interesting ticket title',
        user_id: 1}, tags: ['tag1', 'tAG1', 'tag2', 'tag3', 'TAG3']}

      ticket = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(ticket[:data][:attributes]).to have_key(:title)
      expect(ticket[:data][:attributes]).to have_key(:user_id)
      expect(Ticket.count).to eq(1)
    end
  end

  describe 'sad path' do
    it 'shows an error message when attribute is missing' do
      post '/api/v1/tickets', params: {ticket: {user_id: 1},
        tags: ['tag1', 'tAG1', 'tag2', 'tag3', 'TAG3']}

      ticket = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(422)
      expect(ticket[:errors]).to eq(["Title can't be blank"])
    end

    it 'shows an unprocessible entity status when length is over five' do
      post '/api/v1/tickets', params: {ticket: {user_id: 1, title: 'Title'},
        tags: ['tag1', 'tAG1', 'tag2', 'tag3', 'TAG3', 'tag10']}

      expect(response.status).to eq(422)
    end
  end
end
