class User < ActiveRecord::Base
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :questions
  has_many :question_comments
  has_many :answers
  has_many :answer_comments
  has_many :votes

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)
    if user.nil?
      user = User.create(
        email: auth.info.email, 
        password: Devise.friendly_token[0,20], 
        username: auth.info.name, 
        confirmation_token: nil, 
        confirmed_at: Time.now.utc,
        avatar_url: auth.info.image,
        confirmation_sent_at: Time.now.utc)
    end

    if !user.persisted?
      user.confirmation_token = nil
      user.confirmed_at = Time.now.utc
      user.confirmation_sent_at = Time.now.utc
      user.skip_confirmation!
      user.avatar_url= auth.info.image
      user.save
    end
    user.update_attribute(:avatar_url, auth.info.image)
    user
  end

  def comments
    self.question_comments.count + self.answer_comments.count
  end

  def avatar
    return self.avatar_url unless self.avatar_url.nil?
    self.gravatar_url(:size => 200, :default => "identicon")
  end

end
