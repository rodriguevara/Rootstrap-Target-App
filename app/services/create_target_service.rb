class CreateTargetService
  def initialize(current_user, other_user, topicid)
    @current_user = current_user
    @other_user = other_user
    @topic_id = topicid
  end

  def create_chat!
    return if already_created?(@current_user, @other_user)

    conversation = @current_user.conversations.create!(topic_id: @topic_id)
    @other_user.conversations << conversation
    conversation
  end

  private

  def already_created?(current_user, other_user)
    current_user.conversations.any? { |conversation| conversation.users.include?(other_user) }
  end
end
