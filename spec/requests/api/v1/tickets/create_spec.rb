require 'rails_helper'

RSpec.describe 'Create Tickets' do
  describe 'happy path' do
    it 'creates a ticket with correct params', :vcr do
      post '/api/v1/tickets', params: {ticket: {title: "Interesting ticket title",
         tags: ["tag1", "tAG1", "tag2", "tag3", "TAG3"], user_id: 1}}

      ticket = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(ticket[:data][:attributes][:tags].count).to eq(5)
      expect(ticket[:data][:attributes]).to have_key(:tags)
      expect(ticket[:data][:attributes]).to have_key(:title)
      expect(ticket[:data][:attributes]).to have_key(:user_id)
      expect(Ticket.count).to eq(1)
    end
  end

  describe 'sad path' do
    it 'shows an error message when attribute is missing', :vcr do
      post '/api/v1/tickets', params: {ticket: {user_id: 1,
         tags: ["tag1", "tAG1", "tag2", "tag3", "TAG3"]}}

      ticket = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(422)
      expect(ticket[:errors]).to eq(["Title can't be blank"])
    end
  end
end
