require 'rails_helper'

feature 'Deadline' do

  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:project) { user.projects.last }
  let!(:task) { FactoryGirl.create(:task, project: project) }

  scenario 'user can choose deadline for task', js: true do
    sign_in
    check_tasks
    assign_deadline
  end

  private

  def check_tasks
    expect(page).to have_css('.each-task', count: 1)
    expect(page).to have_css('span.deadline', text: task.deadline)
  end

  def assign_deadline
    expect(page).to have_css('.each-task .glyphicon.glyphicon-calendar',
                             visible: false)
    find('.each-task p', text: task.title).hover
    expect(page).to have_css('.each-task .glyphicon.glyphicon-calendar',
                             visible: true)
    find(:css, '.each-task .glyphicon.glyphicon-calendar').trigger('click')
    expect(page).to have_css('.task-buttons .dropdown-menu td.day')
    find('.dropdown-menu td.day', text: '11').click
    sleep 1
    expect(page).not_to have_css('.dropdown-menu td.day')
    expect(page).to have_css('span.deadline', text: Task.find(task.id).deadline)
  end
end