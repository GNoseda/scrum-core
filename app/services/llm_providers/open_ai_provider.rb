module LlmProviders
  class OpenAiProvider < BaseProvider
    MODEL = "gpt-4o"

    def initialize
      @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
    end

    def generate(messages)
      response = @client.chat(
        parameters: {
          model: MODEL,
          messages: messages.map { |m| { "role" => m[:role].to_s, "content" => m[:content] } }
        }
      )

      content = response.dig("choices", 0, "message", "content")
      LlmResponseParser.parse(content)
    end
  end
end
