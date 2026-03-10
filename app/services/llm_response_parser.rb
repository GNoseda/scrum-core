class LlmResponseParser

  def self.parse(response_text)
    begin
      parsed = JSON.parse(response_text)

      {
        message: parsed["message"],
        artifact_patch: parsed["artifact_patch"]
      }

    rescue JSON::ParserError
      {
        message: response_text,
        artifact_patch: nil
      }
    end
  end

end