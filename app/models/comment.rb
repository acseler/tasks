class Comment < ApplicationRecord
  belongs_to :task
  has_many :attachments, dependent: :destroy

  validates :message, presence: true
end
