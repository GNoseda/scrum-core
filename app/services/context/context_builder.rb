module Context
  class ContextBuilder

    PROVIDERS = [
      Context::Providers::ConversationHistoryProvider
    ]

    def initialize(session:)
      @session = session
    end

    def call
      PROVIDERS.flat_map do |provider|
        provider.new(session: @session).call
      end
    end

  end
end