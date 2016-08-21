class Task < ApplicationRecord
  belongs_to :project

  validates :title, presence: true, length: { maximum: 256 }

  default_scope { order(:priority) }
end
