Rails.application.routes.draw do
  scope '/api' do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
  root 'application#angular'
  get '*path.html' => 'application#angular', :layout => 0
  get '*path' => 'application#angular'
end
