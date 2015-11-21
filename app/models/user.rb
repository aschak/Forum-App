class User < ActiveRecord::Base
  attr_reader :password

  after_initialize :ensure_session_token

  validates :username, :session_token, uniqueness: true
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :subs,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "Sub",
    dependent: :destroy

  has_many :posts,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: "Post",
    dependent: :destroy

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  private
  # TODO
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

end
