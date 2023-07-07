class RemoveTopicIdFromConversations < ActiveRecord::Migration[7.0]
  def change
    add_reference :conversations, :topic, null: false, foreign_key: true, default: ''
  end
end
