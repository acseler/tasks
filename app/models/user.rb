class User < ApplicationRecord
  # Include default devise modules.
  before_save -> { skip_confirmation! }
  has_many :projects, dependent: :destroy

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
