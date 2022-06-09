require 'net/http'

class Api::V1::TicketsController < ApplicationController
  def create
    ticket = Ticket.new(ticket_params)
    if ticket.save
        render json: TicketSerializer.new(ticket), status: :created
        unique_tags = Tag.unique_tags(ticket_params[:tags])
        hishest_tag_count = Tag.get_count(unique_tags)

        uri = URI("https://webhook.site/a4a30c0e-9847-4c00-bb1e-673ac1436a2e?highest_count_tag=#{hishest_tag_count.tag_name}")
        Net::HTTP.post_form(uri,'created_ticket' => "#{ticket}")
    else
        render json: { errors: ticket.errors.full_messages }, status: 422
    end
  end

  private

  def ticket_params
      params.require(:ticket).permit(:user_id, :title, :tags => [])
  end
end
