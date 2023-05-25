# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# require "faker"
require "open-uri"
require "json"

Movie.destroy_all

# 50.times do
#   Movie.create(
#     title: Faker::Movie.title,
#     overview: Faker::Quote.matz,
#     rating: rand(0.0..10.0).round(1)
#   )
# end

url = "https://tmdb.lewagon.com/movie/top_rated"
img_url = "https://image.tmdb.org/t/p/w500"

json = JSON.parse(URI.open(url).read)

# puts json["results"][1]

json["results"].each do |el|
  Movie.create(
    title: el["original_title"],
    overview: el["overview"],
    rating: el["vote_average"],
    poster_url: img_url + el["poster_path"]
  )
end
