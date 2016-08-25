class Comment < ApplicationRecord
  belongs_to :task

  validates :message, presence: true
end
