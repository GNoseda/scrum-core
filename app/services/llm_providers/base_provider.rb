module LlmProviders
  class BaseProvider
    # @param messages [Array<Hash>] array of { role:, content: } hashes
    # @return [Hash] { message: String, artifact_patch: Hash|nil }
    def generate(messages)
      raise NotImplementedError, "#{self.class} must implement #generate"
    end
  end
end
