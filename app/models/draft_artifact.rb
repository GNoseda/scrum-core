class DraftArtifact < ApplicationRecord
  belongs_to :session

  validates :artifact_type, presence: true
  validates :version, presence: true
  validates :structured_content, presence: true

  enum :artifact_type, {
    project: "project",
    epic: "epic",
    story: "story"
  }
end