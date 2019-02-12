class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :note
  validates :user, presence: true
  validates :note, presence: true
end
