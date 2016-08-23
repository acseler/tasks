class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :project_id, :completed, :priority, :deadline

  belongs_to :project
end
