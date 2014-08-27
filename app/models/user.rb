class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: {admin: 'admin', general: 'general'}
  has_many :comments
end
