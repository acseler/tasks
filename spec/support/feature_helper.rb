module FeatureHelper
  def sign_in
    visit '/'
    sleep 2
    sign_in_user(user.email, '12345678')
  end

  def sign_in_user(email, password)
    sleep 2
    within 'form' do
      fill_in 'email', with: email
      fill_in 'password', with: password
    end
    click_button('Sign in')
    sleep 0.5
  end
end