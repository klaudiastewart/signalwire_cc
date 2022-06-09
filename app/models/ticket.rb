class Ticket < ApplicationRecord
  validates :user_id, presence: true
  validates :title, presence: true
  validates :tags, length: {
    maximum: 5
  }
end
