class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :note
  #self.per_page = 2
end
