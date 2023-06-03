module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def index
        @targets = policy_scope(current_user.targets)
      end

      def create
        authorize Target
        @target = current_user.targets.create!(target_params)
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
