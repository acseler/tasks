class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :project_id, :completed, :priority, :deadline

  has_many :comments
  belongs_to :project
end
