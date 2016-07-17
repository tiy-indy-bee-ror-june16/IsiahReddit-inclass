module ApplicationHelper
  def set_subreddits
    @subreddits = Subreddit.all
    @num = 1 + ((@links.current_page - 1) * 10)
  end
end
