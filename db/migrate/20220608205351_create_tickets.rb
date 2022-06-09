class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.string :title
      t.text :tags, array: true, default: []

      t.timestamps
    end
  end
end
