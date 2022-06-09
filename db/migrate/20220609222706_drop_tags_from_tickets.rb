class DropTagsFromTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :tags
  end
end
