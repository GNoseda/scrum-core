class User < ApplicationRecord
  has_many :sessions, dependent: :destroy

  validates :email, uniqueness: true, allow_nil: true
end