class User < ApplicationRecord
  belongs_to :organization
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :reset_authentication_token

  ROLES = {
    user: 'user',
    superuser: 'superuser',
    admin: 'admin'
  }.freeze

  enum role: ROLES
end
