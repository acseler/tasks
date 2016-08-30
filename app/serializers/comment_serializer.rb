class CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :task_id

  belongs_to :task
  has_many :attachments
end