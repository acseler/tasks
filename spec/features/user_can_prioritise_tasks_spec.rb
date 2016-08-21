require 'rails_helper'

feature 'Task prioritise' do

  before do
    3.times {FactoryGirl.create(:task,:empty_priority, project: project)}
  end

  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:project) { user.projects.first }
  let!(:tasks) { project.tasks }
  let!(:task_three) { tasks.last }

  scenario 'user can prioritise tasks', js: true do
    sign_in
    check_tasks
    check_priority_assignation
  end

  private

  def check_tasks
    expect(page).to have_css('.each-task', count: 3)
  end

  def check_priority_assignation
    tasks.each do |task|
      expect(task.priority).to be_nil
    end
    task_to_prioritise = page.find('.project-tasks p', text: task_three.title)
    target = page.find('a', text: 'Sign out')
    task_to_prioritise.drag_to(target)
    sleep 2
    Project.find(project.id).tasks.each do |task|
      expect(task.priority).not_to be_nil
    end
  end
end