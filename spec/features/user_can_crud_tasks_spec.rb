require 'rails_helper'

feature 'Task' do

  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:project) { user.projects.last }
  let!(:task) { FactoryGirl.create(:task, project: project) }
  let(:task_title) { 'Task title 1' }
  let(:new_task_title) { 'Task title updated' }
  let(:checkbox_selector) { "input[name='completed']" }

  scenario 'user can add tasks to project', js: true do
    sign_in
    check_add_task_form
    fill_in_and_add_task
    check_new_task_adding
  end

  scenario 'user can update tasks', js: true do
    sign_in
    check_tasks
    check_edit_task_title
    fill_in_and_update_task
  end

  scenario 'user can delete tasks', js: true do
    sign_in
    check_tasks
    check_delete_button
  end

  scenario 'user can mark a task as done', js: true do
    sign_in
    check_tasks
    check_complete_tasks
  end

  private

  def check_add_task_form
    expect(page).to have_css('.panel.panel-primary .panel-body project-tasks')
    expect(page).to have_css('form#addTaskForm')
    expect(page).to have_css('.input-group.input-group-sm input.form-control')
    expect(page).to have_css('.input-group-btn button.btn.btn-sm.btn-primary',
                             text: 'Add Task')
    expect(page).to have_content(task.title)
  end

  def check_tasks
    expect(page).to have_css('.each-task', count: 1)
  end

  def check_edit_task_title
    expect(page).to have_css('.each-task .task-buttons .glyphicon.glyphicon-pencil',
                             visible: false)
    find('.each-task p', text: task.title).hover
    expect(page).to have_css('.each-task .task-buttons .glyphicon.glyphicon-pencil',
                             visible: true)
    find('.each-task .task-buttons .glyphicon.glyphicon-pencil').click
    expect(page).to have_css('form#update_task_title')
    expect(page).to have_css('.form-control.input-sm')
    expect(page).to have_css('.input-group-btn button.btn.btn-primary')
  end

  def check_delete_button
    expect(page).to have_css('.each-task .glyphicon.glyphicon-trash',
                             visible: false)
    find('.each-task p', text: task.title).hover
    expect(page).to have_css('.each-task .glyphicon.glyphicon-trash',
                             visible: true)
    expect(page).to have_css('.each-task', count: 1)
    accept_confirm do
      find(:css, '.each-task .task-buttons .glyphicon.glyphicon-trash').trigger('click')
      sleep 1
    end
    expect(page).to have_css('.each-task', count: 0)
  end

  def check_complete_tasks
    checkbox = find(checkbox_selector)
    expect(page).to have_selector(checkbox_selector)
    expect(task.completed).to be false
    expect(checkbox.checked?).to be false
    check('completed')
    sleep 1
    expect(Task.find(task.id).completed).to be true
  end

  def fill_in_and_add_task
    within '#addTaskForm' do
      fill_in 'title', with: task_title
    end
    click_button('Add Task')
    sleep 1
  end

  def fill_in_and_update_task
    within '#update_task_title' do
      fill_in 'task_title', with: new_task_title
    end
    click_button('Save')
    sleep 1
  end

  def check_new_task_adding
    expect(page).to have_css('.each-task .col-xs-8 p', text: task_title)
  end
end