class Subreddit < ActiveRecord::Base
  has_many :links
  validates :name, exclusion: {in: %w(subreddits links users),
    message: "%{value} is reserved."}

  def self.searched_subreddits(params)
    @searched_subreddits = Subreddit.where("name LIKE ?", "%#{params}%")
  end
end
