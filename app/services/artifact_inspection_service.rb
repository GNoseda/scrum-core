class ArtifactInspectionService

  def initialize(artifact:)
    @artifact = artifact
  end

  def missing_fields
    @artifact.content.select { |_, value| value.blank? }.keys
  end

  def next_field
    missing_fields.first
  end

end