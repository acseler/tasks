class ProjectService
  attr_reader :project

  def initialize(project)
    @project = project
  end

  def call
    update_project
  end

  private

  def update_project
    proj = Project.find_by(id: project[:id])
    proj.update(project)
    proj
  end

  def project_for_update
    Project.find_by(id: project[:id])
  end
end