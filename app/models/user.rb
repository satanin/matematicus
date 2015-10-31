class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :questions
  has_many :answers

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)
    user = User.create(email: auth.info.email, password: Devise.friendly_token[0,20], username: auth.info.name, confirmation_token: nil, confirmed_at: Time.now.utc, confirmation_sent_at: Time.now.utc) if user.nil?
    user
  end

end
