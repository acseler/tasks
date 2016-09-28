class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :project_id, :completed, :priority, :deadline

  has_many :comments
end
