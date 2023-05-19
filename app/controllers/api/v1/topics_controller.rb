module Api
  module V1
    class TopicsController < Api::V1::ApiController
      def index
        render json: @topics = policy_scope(Topic), only: %i[id label], include: [:image]
      end
    end
  end
end
