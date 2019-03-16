# frozen_string_literal: true

# Managing Note Model
class Note < ApplicationRecord
  # Associations
  belongs_to :user
  has_many(
    :comments,
    dependent: :destroy
  )
  has_many :note_shares
  #has_many :tags, through: :taggings

  # Validations
  validates :user, presence: true
  validates :title, presence: true
  validates(
    :description,
    presence: true,
    length: {
      minimum: 5,
      maximum: 500
    }
  )

  acts_as_taggable_on :tags
end
