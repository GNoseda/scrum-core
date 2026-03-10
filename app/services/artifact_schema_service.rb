class ArtifactSchemaService

  def self.schema_for(type)

    case type

    when "epic"
      {
        title: nil,
        problem: nil,
        outcome: nil,
        scope: [],
        user_stories: []
      }

    when "user_story"
      {
        title: nil,
        description: nil,
        acceptance_criteria: []
      }

    else
      {}
    end

  end

end