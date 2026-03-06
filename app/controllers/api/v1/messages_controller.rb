module Api
  module V1
    class MessagesController < BaseController

      def create
        session = Session.find(params[:session_id])

        result = MessageOrchestratorService.new(
          session: session,
          content: params[:content]
        ).call

        render_success(result, status: :created)
      end

    end
  end
end