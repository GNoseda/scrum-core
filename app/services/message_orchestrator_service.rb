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

    artifact = ArtifactManagerService.new(
      session: @session,
      user_message: user_message,
      ai_message: nil,
      artifact_patch: nil
    ).send(:find_or_create_artifact)

    inspection = ArtifactInspectionService.new(
      artifact: artifact
    )

    missing_fields = inspection.missing_fields
    next_field = inspection.next_field

    prompt = PromptBuilderService.new(
      session: @session,
      context: context,
      artifact: artifact,
      missing_fields: missing_fields,
      next_field: next_field
    ).build
    
    field_strategy = ArtifactFieldStrategyService.new(
      artifact: artifact,
      missing_fields: missing_fields
    )



    ai_result = LlmClient.new.generate(prompt)

    assistant_message = Message.create!(
      session: @session,
      role: :assistant,
      content: ai_result[:message]
    )

    artifact = ArtifactManagerService.new(
      session: @session,
      user_message: user_message,
      ai_message: assistant_message,
      artifact_patch: ai_result[:artifact_patch]
    ).call

    {
      user_message: serialize_message(user_message),
      assistant_message: serialize_message(assistant_message),
      artifact: serialize_artifact(artifact),
      artifact_insights: {
        missing_fields: missing_fields
      }
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

  def serialize_artifact(artifact)
    return nil unless artifact

    {
      id: artifact.id,
      session_id: artifact.session_id,
      artifact_type: artifact.artifact_type,
      status: artifact.status,
      content: artifact.content,
      created_at: artifact.created_at,
      updated_at: artifact.updated_at
    }
  end

end