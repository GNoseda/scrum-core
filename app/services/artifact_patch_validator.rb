class ArtifactPatchValidator

  def initialize(artifact:, patch:)
    @artifact = artifact
    @patch = patch || {}
  end

  def call
    return {} if @patch.blank?

    allowed_fields = @artifact.content.keys
    missing_fields = missing_fields()

    # Solo permitir campos del schema
    filtered_patch = @patch.slice(*allowed_fields)

    # Solo permitir campos que aún están vacíos
    filtered_patch.slice(*missing_fields)
  end

  private

  def missing_fields
    @artifact.content.select { |_, value| value.blank? }.keys
  end

end