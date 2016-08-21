class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :project_id, :completed, :priority

  belongs_to :project
end
