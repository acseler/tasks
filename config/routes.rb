Rails.application.routes.draw do
  root 'application#angular'
  scope '/api' do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      shallow do
        resources :projects do
          resources :tasks do
            resources :comments
          end
        end
      end
    end
  end
  get '*path.html' => 'application#angular', :layout => 0
  get '*path' => 'application#angular'
end
