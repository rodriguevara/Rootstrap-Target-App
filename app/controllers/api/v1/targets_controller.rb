module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def index
        @targets = policy_scope(current_user.targets)
      end

      def create
        authorize Target
        @target = current_user.targets.create!(target_params)
        @compatible_users = @target.compatible_targets.map do |target|
          compatible_user = target.user
          Conversation.create_chat(current_user, compatible_user)
          compatible_user
        end
        @compatible_users = @compatible_users.uniq
      end

      def destroy
        @target = current_user.targets.find(params[:id])
        authorize @target
        @target.destroy!
      end

      private

      def target_params
        params.require(:target).permit(:title, :radius, :lat, :lon, :topic_id)
      end
    end
  end
end
