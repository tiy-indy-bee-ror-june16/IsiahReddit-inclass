class User < ActiveRecord::Base
  has_secure_password
  has_many :links
  has_many :votes
  has_many :voted_links, through: :votes, source: :link
  validates :username, :password, :email, presence: true
  validates :username, length: {maximum: 25}
  validates :password, length: {minimum: 6}
  validates_format_of :email, :with => /.+@.+\..+/i

  def self.searched_users(params)
    where("username LIKE ?", "%#{params}%")
  end

  def upvoted_links
    voted_links.where("votes.value = 1.0").uniq
  end

  def downvoted_links
    voted_links.where("votes.value = -1.0").uniq
  end

  def clicked_links
    voted_links.where("votes.value = 0.2").uniq
  end

  def to_param
    username
  end

end
