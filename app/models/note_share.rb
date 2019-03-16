# frozen_string_literal: true

# Managing NoteShare
class NoteShare < ApplicationRecord
  # Associations
  belongs_to :note
  belongs_to :user

  # Validations
  validates :email, presence: true

  # Methods

  # Fetch the notes title
  def title
    note.title
  end

  # Fetch the notes description
  def description
    note.description
  end

  # Fetch the user username
  def username
    user.username
  end

end
