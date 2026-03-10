class Session < ApplicationRecord
  belongs_to :user, optional: true
  has_many :messages, dependent: :destroy
  has_many :draft_artifacts, dependent: :destroy
  has_many :artifacts, dependent: :destroy

  validates :session_type, presence: true
  validates :status, presence: true

  enum :session_type, {
    project_creation: "project_creation",
    epic_creation: "epic_creation",
    story_creation: "story_creation"
  }

  enum :status, {
    exploring: "exploring",
    structuring: "structuring",
    refining: "refining",
    ready_to_publish: "ready_to_publish",
    error: "error"
  }

  def active_artifact
    artifacts.last
  end
end