class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations, &:timestamps
  end
end
