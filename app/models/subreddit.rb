class Subreddit < ActiveRecord::Base
  has_many :links
  validates :name, exclusion: {in: %w(subreddits links users),
    message: "%{value} is reserved."}

  def self.searched_subreddits(params)
    where("name LIKE ?", "%#{params}%")
  end
end
