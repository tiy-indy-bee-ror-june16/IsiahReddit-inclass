class Subreddit < ActiveRecord::Base
  has_many :links

  def self.searched_subreddits(params)
    @searched_subreddits = Subreddit.where("name LIKE ?", "%#{params}%")
  end
end
