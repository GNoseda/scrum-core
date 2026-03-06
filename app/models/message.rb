class Message < ApplicationRecord
  belongs_to :session

  enum :role, {
    user: 0,
    assistant: 1,
    system: 2,
    tool: 3
  }

  validates :content, presence: true
  validates :role, presence: true
end