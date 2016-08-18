require 'rails_helper'

feature 'Task' do

  let(:user) { FactoryGirl.create(:confirmed_user) }
  let(:project) { user.project }
  let(:task) { FactoryGirl.create(:task, project: project) }
  let(:task_title) { 'Task title new' }

  scenario 'User can add tasks to project', js: true do
    sign_in
    check_add_task_form
    fill_in_and_add_task
    check_new_task_adding
  end

  private

  def check_add_task_form
    expect(page).to have_css('.panel.panel-primary .panel-body project-tasks')
    expect(page).to have_css('form#addTaskForm')
    expect(page).to have_css('.input-group.input-group-sm input.form-control')
    expect(page).to have_css('.input-group-btn button.btn.btn-sm.btn-primary',
                             text: 'Add Task')
  end

  def fill_in_and_add_task
    within '#addTaskForm' do
      fill_in 'title', with: task_title
    end
    click_button('Add Task')
  end

  def check_new_task_adding
    expect(page).to have_css('.each-task .col-xs-9 p', text: task_title)
  end
end