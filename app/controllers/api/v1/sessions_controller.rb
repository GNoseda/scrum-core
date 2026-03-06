module Api
  module V1
    class SessionsController < BaseController
      def create
        permitted = params.permit(:session_type)

        unless permitted[:session_type].present?
          return render_error(
            code: "invalid_request",
            message: "session_type is required",
            status: :unprocessable_entity
          )
        end

        session = Session.new(permitted)

        if session.save
          render_success(
            {
              id: session.id,
              session_type: session.session_type,
              status: session.status,
              created_at: session.created_at
            },
            status: :created
          )
        else
          render_error(
            code: "validation_error",
            message: session.errors.full_messages.join(", "),
            status: :unprocessable_entity
          )
        end
      end

      def show
        session = Session.includes(:messages, :draft_artifacts).find_by(id: params[:id])

        unless session
          return render_error(
            code: "not_found",
            message: "Session not found",
            status: :not_found
          )
        end

        latest_artifact = session.draft_artifacts.order(version: :desc).first

        render_success(
          {
            id: session.id,
            session_type: session.session_type,
            status: session.status,
            messages_count: session.messages.count,
            artifact: latest_artifact&.structured_content
          }
        )
      end
      
    end
  end
end