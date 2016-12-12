class Attachment < ApplicationRecord
  mount_uploader :file, AttachmentUploader

  belongs_to :comment

  validates :file, presence: true
end
