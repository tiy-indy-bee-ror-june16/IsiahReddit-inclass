# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = 100.times.map do
  User.create!(username: Faker::Internet.user_name.split(".").join("_"), description: Faker::Hacker.say_something_smart)
end

subreddits = 10.times.map do
  Subreddit.create!(name:Faker::Book.genre.split(" ").join("_"))
end

links = 1000.times.map do
  Link.create!(
    address:Faker::Internet.url,
    title: [
      Faker::Beer.name,
      Faker::Space.galaxy,
      Faker::University.name,
      Faker::Company.catch_phrase,
      Faker::Space.agency,
      Faker::Hacker.say_something_smart,
      Faker::Hacker.adjective,
      Faker::Address.city
    ].sample(2).join("; "),
    summary: Faker::Hipster.sentence,
    vote_score: ((1..100).to_a.sample) * ((1..40).to_a.sample) - ((1..1000).to_a.sample),
    user: users.sample,
    subreddit: subreddits.sample,
    picture: ["https://placeimg.com/640/480/any", "https://unsplash.it/g/200/300", "http://www.fillmurray.com/200/300", "http://placecage.com/c/200/300", "http://placebear.com/400/200", "http://placekitten.com/300/350", "http://baconmockup.com/300/200", nil, nil, nil, nil].sample
  )
end
