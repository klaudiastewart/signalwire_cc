class Ticket < ApplicationRecord
  has_many :tags

  validates :user_id, presence: true
  validates :title, presence: true
end
