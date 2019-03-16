# frozen_string_literal: true

# Managing Devise User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :confirmable
  )

  # Associations
  has_many :notes
  has_many :note_shares
  has_many :comments
  has_one_attached :picture
  has_many :refunds

  # Validations
  validates(
    :username,
    presence: true,
    length: { minimum: 4 }
  )
end
