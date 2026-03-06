module Context
  module Providers
    class ConversationHistoryProvider

      def initialize(session:)
        @session = session
      end

      def call
        @session.messages.order(:created_at).map do |message|
          {
            role: message.role,
            content: message.content
          }
        end
      end

    end
  end
end