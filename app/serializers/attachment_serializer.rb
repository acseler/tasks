class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :file, :comment_id, :file_identifier

  belongs_to :comment
end