# frozen_string_literal: true

# Managing Comments
class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :note

  # Validations
  validates(
    :user,
    :note,
    :body,
    presence: true
  )
  # validates :note, presence: true
  # validates :body, presence: true
end
