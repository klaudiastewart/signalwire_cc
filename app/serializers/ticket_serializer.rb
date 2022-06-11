class TicketSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :title
end
