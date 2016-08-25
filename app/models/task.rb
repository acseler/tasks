class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :delete_all

  validates :title, presence: true, length: { maximum: 256 }

  default_scope { order(:priority) }
end
