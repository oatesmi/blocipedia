class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, length: { minimum: 3, maximum: 18 }, presence: true
  
  def validate_username
   if User.where(email: username).exists?
     errors.add(:username, :invalid)
   end
  end
end
