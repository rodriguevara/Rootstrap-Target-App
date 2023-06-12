json.match_conversation_id conversation.id
json.topic_id conversation.topic_id
json.matched_user do
  json.extract! conversation.users.where.not(id: current_user.id).first, :id, :username, :first_name
end
