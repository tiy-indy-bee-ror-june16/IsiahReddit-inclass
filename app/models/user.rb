class User < ActiveRecord::Base
  has_many :links
  validates :username, :description, presence: true
  validates :username, length: {maximum: 25}

  def self.searched_users(params)
    @searched_users = User.where("username LIKE ?", "%#{params}%")
  end

end
