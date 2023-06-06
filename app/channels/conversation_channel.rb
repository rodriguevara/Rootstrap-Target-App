class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find_by(id: params[:conversation_id])
    stream_for conversation
  end

  def receive(data)
    conversation = Conversation.find_by(id: params[:conversation_id])
    message = conversation.messages.create!(user_id: data['user_id'], body: data['body'])
    ConversationChannel.broadcast_to(conversation, message)
  end
end
