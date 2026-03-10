class LlmClient

  def generate(prompt)

    {
      message: "Stub AI response based on #{prompt.size} messages",
      artifact_patch: infer_patch_from_prompt(prompt)
    }

  end

  private

  def infer_patch_from_prompt(prompt)
    last_user_message = prompt.reverse.find { |m| m[:role] == "user" }

    return nil unless last_user_message

    content = last_user_message[:content].downcase

    if content.include?("check-in")
      {
        title: "Improve check-in experience"
      }
    end
  end

end