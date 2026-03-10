class ArtifactManagerService

    def initialize(session:, user_message:, ai_message:, artifact_patch: nil)
        @session = session
        @user_message = user_message
        @ai_message = ai_message
        @artifact_patch = artifact_patch
    end

    def call
        artifact = find_or_create_artifact
        merge_patch_into_artifact(artifact) if @artifact_patch.present?
        artifact
    end

private 

    def find_or_create_artifact
        artifact = @session.active_artifact
        return artifact if artifact.present?

        schema = ArtifactSchemaService.schema_for("epic")

        Artifact.create!(
            session: @session,
            artifact_type: "epic",
            status: "drafting",
            content: schema.deep_dup
        )
    end

    def merge_patch_into_artifact(artifact)

        return unless @artifact_patch

        schema = ArtifactSchemaService.schema_for(artifact.artifact_type)
        allowed_keys = schema.keys

        filtered_patch = @artifact_patch
            .deep_stringify_keys
            .slice(*allowed_keys)

        missing_fields = artifact.content
            .select { |_, value| value.blank? }
            .keys

        validated_patch = filtered_patch.slice(*missing_fields)

        return if validated_patch.blank?

        artifact.update!(
            content: artifact.content.deep_merge(validated_patch)
        )   

    end

end