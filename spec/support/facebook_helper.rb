module FacebookHelper
  def configure_omniauth
    mock_auth
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end

  def mock_auth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] =
        OmniAuth::AuthHash.new(provider: 'facebook',
                               uid: '11111111111',
                               info: {email: FFaker::Internet.email})
  end
end

RSpec.configure do |config|
  config.include FacebookHelper
end
