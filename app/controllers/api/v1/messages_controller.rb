module Api
  module V1
    class MessagesController < BaseController

      def create
        session = Session.find(params[:session_id])

        result = MessageOrchestratorService.new(
          session: session,
          content: params[:content]
        ).call

        render json: {
          data: {
            user_message: result[:user_message],
            assistant_message: result[:assistant_message],
            artifact: result[:artifact],
            artifact_insights: result[:artifact_insights]
          },
          meta: { api_version: "v1" },
          error: nil
        }
      end

    end
  end
end