class CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :task_id

  has_many :attachments
end