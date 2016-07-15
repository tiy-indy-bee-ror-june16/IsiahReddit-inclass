json.array!(@links) do |link|
  json.extract! link, :id, :address, :title, :summary, :vote_score, :subreddit_id, :user_id
  json.url link_url(link, format: :json)
end
