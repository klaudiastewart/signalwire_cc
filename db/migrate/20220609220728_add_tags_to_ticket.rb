class AddTagsToTicket < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :ticket, foreign_key: true
  end
end
