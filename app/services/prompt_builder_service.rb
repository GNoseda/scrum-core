class PromptBuilderService
    MAX_HISTORY_MESSAGES = 10

    def initialize(session:, context:, artifact:, missing_fields:, next_field:)
        @session = session
        @context = context
        @artifact = artifact
        @missing_fields = missing_fields
        @next_field = next_field
    end

    def build
        [
            system_prompt,
            artifact_state,
            missing_fields_prompt,
            conversation_history
        ].flatten
    end

    private

    def conversation_history
        return [] unless @session

        messages = @session.messages
        .order(created_at: :asc)
        .last(MAX_HISTORY_MESSAGES)

        messages.map do |message|
        {
            role: message.role,
            content: message.content
        }
        end
    end

    def system_prompt
        {
            role: "system",
            content: <<~PROMPT
            You are an AI assistant helping a Product Owner draft a product artifact through conversation.

            The artifact is being progressively constructed during the conversation.

            Your responsibilities:

            1. Analyze the user's messages and infer relevant information.
            2. Extract information that fits the artifact schema.
            3. Update the artifact only when you are confident about the information.
            4. If information is unclear or missing, ask natural follow-up questions.
            5. Never ask questions like a form. Maintain a natural conversation.

            When you detect information relevant to the artifact, return it as an artifact_patch.

            Only include fields you are confident about. Do not invent information.

            The artifact evolves incrementally during the conversation.
                PROMPT
        }
    end

    def artifact_state
        return [] unless @artifact

        {
            role: "system",
            content: <<~STATE
        Current artifact type: #{@artifact.artifact_type}

        Current artifact content:
        #{@artifact.content.to_json}
        STATE
        }
    end

    def missing_fields_prompt
        return [] if @missing_fields.empty?

        {
            role: "system",
            content: "Fields still missing in the artifact:\n#{@missing_fields.join(', ')}"
        }
    end


end