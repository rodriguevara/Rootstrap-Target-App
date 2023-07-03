class RemoveTopicIdFromConversations < ActiveRecord::Migration[7.0]
  def change
    remove_column :conversations, :topic_id, :integer
    add_reference :conversations, :topic, null: false, foreign_key: true
  end
end
