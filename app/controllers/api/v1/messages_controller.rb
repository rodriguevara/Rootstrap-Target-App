module Api
  module V1
    class MessagesController < Api::V1::ApiController
      def index
        @messages =
          policy_scope(conversation.messages).order(created_at: :desc).page(params[:page])
                                             .per(Message::MAX_MESSAGES)
      end

      def create
        authorize Message
        @conversation = Conversation.find(params[:conversation_id])
        @message = @conversation.messages.create!(message_params)
        ConversationChannel.broadcast_to(@conversation, @message)
      end

      private

      def message_params
        defaults = { user_id: current_user.id }
        params.require(:message).permit(:user_id, :body).reverse_merge(defaults)
      end

      def conversation
        @conversation ||= current_user.conversations.find(params[:conversation_id])
      end
    end
  end
end
