class Note < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user, presence: true
  #validates :search, presence: true, acceptance: { message: 'Can`t be blank' },length: { minimum: 1 }
end
