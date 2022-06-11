require 'net/http'

class Api::V1::TicketsController < ApplicationController
  before_action :get_unique_tags, only: %i[create]

  def create
    ticket = Ticket.new(ticket_params)
    
    if ticket.save
      render json: TicketSerializer.new(ticket), status: :created
      highest_tag_count = Tag.get_count(ticket, get_unique_tags)
      post_form(highest_tag_count, ticket)
    else
      render json: { errors: ticket.errors.full_messages }, status: 422
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:user_id, :title)
  end

  def post_form(highest_tag_count, ticket)
    uri = URI("https://webhook.site/a4a30c0e-9847-4c00-bb1e-673ac1436a2e?highest_count_tag=#{highest_tag_count.tag_name}")
    Net::HTTP.post_form(uri,'created_ticket' => "#{ticket}")
  end

  def get_unique_tags
    if params[:tags].present? && params[:tags].size > 5
      render json: { errors: 'Tags have maximum length of 5' }, status: 422
    else
      Tag.unique_tags(params[:tags])
    end
  end
end
