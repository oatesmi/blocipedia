class User < ApplicationRecord
  has_many :wikis
  has_many :collaborators
  has_many :wikis_collaborators, source: 'wiki', through: :collaborators

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         authentication_keys: [:login]

  attr_accessor :login


  after_initialize { self.role ||= :standard }
  before_save { self.email ||= email.downcase }
  after_update :wikis_to_public

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 15 }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 6 }

  enum role: [:standard, :premium, :admin]

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  private

  def wikis_to_public
    wikis.update_all(private: false)
  end
end
