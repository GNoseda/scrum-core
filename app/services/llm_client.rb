class LlmClient
  PROVIDERS = {
    "openai" => -> { LlmProviders::OpenAiProvider.new }
  }.freeze

  def generate(messages)
    provider = resolve_provider
    return provider.generate(messages) if provider

    stub_generate(messages)
  end

  private

  def resolve_provider
    factory = PROVIDERS[ENV.fetch("LLM_PROVIDER", "stub")]
    factory&.call
  end

  def stub_generate(messages)
    {
      message: "Stub AI response based on #{messages.size} messages",
      artifact_patch: infer_patch_from_prompt(messages)
    }
  end

  def infer_patch_from_prompt(messages)
    last_user_message = messages.reverse.find { |m| m[:role] == "user" }
    return nil unless last_user_message

    content = last_user_message[:content].downcase

    if content.include?("check-in")
      { title: "Improve check-in experience" }
    end
  end
end
