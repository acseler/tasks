require 'rails_helper'

feature 'Authentication' do
  before do
    FactoryGirl.create(:confirmed_user)
  end

  let(:user) { User.last }

  scenario 'user can sign in by email and password', js: true do
    visit '/'
    check_sign_in_form
    sign_in_user_valid_params
    expect(page).to have_css('a', text: 'Sign out')
  end

  scenario 'user can see messages if wrong email or password', js: true do
    visit '/'
    check_sign_in_form
    sign_in_user_invalid_params
  end

  scenario 'user can sign up', js: true do
    visit '/'
    check_sign_in_form
    click_link('Sign up')
    check_sign_up_fields
    fill_in_sign_up_and_register
    expect(page).to have_content('Sign out')
    sleep 1
  end

  scenario 'user can sign in with facebook', js: true do
    mock_auth
    visit '/'
    check_sign_in_form
    click_link('Facebook')
    expect(page).to have_content('Sign out')
    sleep 1
  end

  private

  def check_sign_in_form
    expect(page).to have_css('h2', text: 'Sign in')
    expect(page).to have_selector("input[id='email']")
    expect(page).to have_selector("input[id='password']")
    expect(page).to have_css('button.btn.btn-primary', text: 'Sign in')
    expect(page).to have_css('a.btn.btn-default', text: 'Facebook')
  end

  def check_sign_up_fields
    expect(page).to have_css('h2', text: 'Sign up')
    expect(page).to have_selector("input[id='email']")
    expect(page).to have_selector("input[id='password']")
    expect(page).to have_selector("input[id='password_confirmation']")
    expect(page).to have_css('button.btn.btn-primary', text: 'Sign up')
  end

  def fill_in_sign_up_and_register
    within 'form' do
      fill_in 'email', with: 'qqq@qqq.qqq'
      fill_in 'password', with: '12345678'
      fill_in 'password_confirmation', with: '12345678'
    end
    click_button('Sign up')
  end

  def sign_in_user_valid_params
    sign_in_user(user.email, '12345678')
    expect(page).not_to have_content('Wrong email or password')
  end

  def sign_in_user_invalid_params
    sign_in_user(user.email, 'wrong password')
    expect(page).to have_content('Wrong email or password')
  end
end