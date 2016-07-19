class User < ActiveRecord::Base
  has_secure_password
  has_many :links
  has_many :votes
  validates :username, :password, :email, presence: true
  validates :username, length: {maximum: 25}
  validates :password, length: {minimum: 6}
  validates_format_of :email, :with => /.+@.+\..+/i

  def self.searched_users(params)
    @searched_users = User.where("username LIKE ?", "%#{params}%")
  end

  def to_param
    username
  end

end
