class CreateCreateJoinTableConversationUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :conversations, :users do |t|
      t.index %i[conversation_id user_id]
    end
  end
end
