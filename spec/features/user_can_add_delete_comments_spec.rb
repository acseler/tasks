require 'rails_helper'

feature 'Comments' do

  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:project) { user.projects.last }
  let!(:task) { FactoryGirl.create(:task, project: project) }
  let(:comment_attr) { FactoryGirl.attributes_for(:comment) }

  scenario 'user can add comments', js: true do
    sign_in
    check_tasks
    check_comment_button
    add_comment_and_check
    delete_and_check
  end

  private

  def check_tasks
    expect(page).to have_css('.each-task', count: 1)
  end

  def check_comment_button
    expect(page).to have_css('.each-task .glyphicon.glyphicon-comment',
                             visible: false)
    find('.each-task p', text: task.title).hover
    expect(page).to have_css('.each-task .glyphicon.glyphicon-comment',
                             visible: true)
    find('.each-task .glyphicon.glyphicon-comment').click
    expect(page).to have_css('.col-xs-12 a', text: 'Add Comment')
    expect(page).to have_css('.empty-comments span',
                             text: 'You have no comments yet.')
  end

  def add_comment_and_check
    expect(page).to have_css('form#add_comment_form', visible: false)
    click_link('Add Comment')
    expect(page).to have_css('form#add_comment_form', visible: true)
    fill_in_comment_form
    sleep 1
    expect(page).to have_css('form#add_comment_form', visible: false)
    expect(page).not_to have_css('.empty-comments span',
                             text: 'You have no comments yet.')
    expect(page).to have_css('.thumbnail p.comment',
                             text: comment_attr[:message])
  end

  def delete_and_check
    expect(page).to have_css('.thumbnail .pull-right span.glyphicon-trash')
    find('.thumbnail .pull-right span.glyphicon-trash').click
    sleep 1
    expect(page).to have_css('.empty-comments span',
                                 text: 'You have no comments yet.')
    expect(page).not_to have_css('.thumbnail p.comment',
                             text: comment_attr[:message])
  end

  def fill_in_comment_form
    within '#add_comment_form' do
      fill_in 'message', with: comment_attr[:message]
    end
    click_button('Save')
  end
end