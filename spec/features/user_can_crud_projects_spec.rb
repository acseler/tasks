require 'rails_helper'

feature 'Project' do

  let(:user) { FactoryGirl.create(:confirmed_user) }
  let(:project) { user.projects.first }
  let(:new_title) { 'FFFFFFF' }

  scenario 'user can create project', js: true do
    sign_in
    expect(page).to have_css('button', text: 'Add TODO List')
    click_button('Add TODO List')
    check_add_project_form
    fill_in_project_and_create
    check_new_project('New project')
  end

  scenario 'user can hide project form', js: true do
    sign_in
    expect(page).to have_css('button', text: 'Add TODO List')
    click_button('Add TODO List')
    check_add_project_form
    click_button('Cancel')
    expect(page).to have_css('button', text: 'Add TODO List')
  end

  scenario 'user can edit project title', js: true do
    sign_in
    check_new_project(project.title)
    check_project_edit_fields
  end

  scenario 'user can delete project', js: true do
    sign_in
    check_new_project(project.title)
    check_delete_project
  end

  private

  def check_add_project_form
    expect(page).to have_css("input[name='title']")
    expect(page).to have_css('.input-group-btn')
    expect(page).to have_css('.btn.btn-default', text: 'Add')
    expect(page).to have_css('.btn.btn-default', text: 'Cancel')
  end

  def fill_in_project_and_create
    within '#projectForm' do
      fill_in 'title', with: 'New project'
    end
    click_button('Add')
  end

  def check_new_project(title)
    expect(page).to have_css('.panel-heading')
    expect(page).to have_content(title)
  end

  def check_project_edit_fields
    expect(page).to have_css('.pull-right .glyphicon.glyphicon-pencil', visible: false)
    find('.panel-heading').hover
    expect(page).to have_css('.pull-right .glyphicon.glyphicon-pencil', visible: true)
    find('.pull-right .glyphicon.glyphicon-pencil').click
    expect(page).to have_css('.input-group .form-control')
    expect(page).to have_css('.input-group span.input-group-btn button', text: 'Save')
    within '#projectEditForm' do
      fill_in 'project_title', with: new_title
    end
    click_button('Save')
    expect(page).not_to have_css('.input-group span.input-group-btn button', text: 'Save')
    expect(page).to have_css('span', text: title)
  end

  def check_delete_project
    expect(page).to have_css('.pull-right .glyphicon.glyphicon-trash', visible: false)
    find('.panel-heading').hover
    expect(page).to have_css('.pull-right .glyphicon.glyphicon-trash', visible: true)
    accept_confirm do
      find(:css, '.pull-right .glyphicon.glyphicon-trash').trigger('click')
      sleep 1
    end
    expect(page).not_to have_content(project.title)
  end
end