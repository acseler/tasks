require 'rails_helper'

feature 'Attachment' do

  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:project) { user.projects.last }
  let!(:task) { FactoryGirl.create(:task, project: project) }
  let(:comment_attr) { FactoryGirl.attributes_for(:comment) }


  scenario 'user can add attachment to comment', js: true do
    sign_in
    check_tasks
    check_comments
    add_comment_with_attach
    check_add_attach
  end

  private

  def check_tasks
    expect(page).to have_css('.each-task', count: 1)
  end

  def check_comments
    expect(page).to have_css('.each-task .glyphicon.glyphicon-comment',
                             visible: false)
    find('.each-task p', text: task.title).hover
    expect(page).to have_css('.each-task .glyphicon.glyphicon-comment',
                             visible: true)
    find('.each-task .glyphicon.glyphicon-comment').click
    expect(page).to have_css('.col-xs-12 a', text: 'Add Comment')
    expect(page).to have_css('.comment-wrap', count: 1)
  end

  def add_comment_with_attach
    expect(page).not_to have_css('.attach-wrap')
    expect(page).to have_css('.comment-wrap', count: 1)
    click_link('Add Comment')
    within '#add_comment_form' do
      fill_in 'message', with: comment_attr[:message]
    end
    page.execute_script <<-JS
      $("label[tabindex='-1']").css({
                                      'visibility': 'visible',
                                       'width': '20px',
                                       'height': '20px'
                                    });
    JS
    attach_file 'attachment', "#{Rails.root}/spec/Armed_men.docx"
    expect(page).to have_css('.attach-wrap p.attach-template',
                             text: 'Armed_men.docx')
    expect(page).to have_css('.attach-wrap p.attach-template a',
                             text: 'x')
    find("form#add_comment_form button[role='submit']").click
    sleep 1
  end

  def check_add_attach
    expect(page).to have_css('.comment-wrap', count: 2)
    expect(page).to have_css('.comment-wrap .comment span',
                             text: comment_attr[:message])
    expect(page).to have_css('.comment-wrap a',
                             text: 'Armed_men.docx')
  end
end