module ApplicationHelper
  def set_subreddits
    @subreddits = Subreddit.all
  end
end
