class Link < ActiveRecord::Base
  belongs_to :subreddit
  belongs_to :user
  validates :address, url: {no_local: true}
  validates :address, :title, :user, :subreddit, presence: true
  validates :title, length: {maximum: 200}

  def self.searched_links(params)
    @searched_links = Link.where("summary LIKE ? OR title LIKE ?", "%#{params}%", "%#{params}%").order(vote_score: :desc)
  end
end
