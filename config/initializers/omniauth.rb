OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
  '1562083487434093',
  '691118d8296a322b43dc3b0c6d6156ee',
  scope: 'email', info: 'email'
end