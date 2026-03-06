class MessageOrchestratorService

  def initialize(session:, content:)
    @session = session
    @content = content
  end

  def call

    user_message = Message.create!(
      session: @session,
      role: :user,
      content: @content
    )

    context = Context::ContextBuilder.new(session: @session).call

    ai_response = LlmClient.new.generate(context)

    assistant_message = Message.create!(
      session: @session,
      role: :assistant,
      content: ai_response
    )

    {
      user_message: serialize_message(user_message),
      assistant_message: serialize_message(assistant_message)
    }

  end

  private

  def serialize_message(message)
    {
      id: message.id,
      session_id: message.session_id,
      role: message.role,
      content: message.content,
      references: message.references,
      created_at: message.created_at,
      updated_at: message.updated_at
    }
  end

end