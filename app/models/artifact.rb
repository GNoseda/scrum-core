class Artifact < ApplicationRecord
  belongs_to :session

  validates :artifact_type, presence: true
end