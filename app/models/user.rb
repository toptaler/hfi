class User < ActiveRecord::Base
  # We have introduced some convoluted logic in order to get email addess from twitter users
  # see http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin/#completing-the-signup-process
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  has_many :comments

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: auth.extra.raw_info.name,
                           provider: auth.provider,
                           uid: auth.uid,
                           email: auth.info.email,
                           password: Devise.friendly_token[0, 20],
        )
      end
    end
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      #twitter's api does not provide user's email address, so cannot check user's existence from email
      user = User.create(name: auth.info.name,
                           provider: auth.provider,
                           uid: auth.uid,
                           email: "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
                           password: Devise.friendly_token[0, 20],
        )
    end
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end


end
