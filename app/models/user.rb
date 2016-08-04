class User < ApplicationRecord
  # Include default devise modules.
  before_save -> { skip_confirmation! }

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
          # , :omniauthable
  include DeviseTokenAuth::Concerns::User
end
