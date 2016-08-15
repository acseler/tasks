class Project < ApplicationRecord

  has_many :tasks, dependent: :delete_all
  belongs_to :user

  validates :title, presence: true, length: { maximum: 256 }

  default_scope { order(:title) }
end
