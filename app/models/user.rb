class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: {
    guest: 0,
    admin: 1,
    moderator: 2,
  }

  devise :database_authenticatable, :registerable, :rememberable, :validatable
end
