class ArtifactFieldStrategyService

  FIELD_ORDER = {
    "epic" => [
      "title",
      "problem",
      "outcome",
      "scope",
      "user_stories"
    ]
  }

  def initialize(artifact:, missing_fields:)
    @artifact = artifact
    @missing_fields = missing_fields
  end

  def next_field
    ordered_fields = FIELD_ORDER[@artifact.artifact_type] || []

    ordered_fields.find do |field|
      @missing_fields.include?(field)
    end
  end

end