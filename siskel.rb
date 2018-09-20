require 'httparty'
require 'dotenv/load'

class Siskel
  attr_reader :title, :rating, :year, :run_time, :genre, :director, :writer, :actors, :plot, :language, :country, :awards, :poster, :imd, :metascore, :imdb, :box_office, :production, :website

  def initialize(title, options={})
    url = "http://www.omdbapi.com/?apikey=#{ENV['API_KEY']}&t=#{title}"
    url += "&y=#{options[:year]}" if options[:year]
    url += "&plot=full"           if options[:plot] == :full
    @movie = HTTParty.get(url)
    @run_time = @movie['Runtime']
    @title = @movie['Title'] || "Movie not found!"
    @rating = @movie['Rated']
    @year = @movie['Year']
    @genre = @movie['Genre']
    @director = @movie['Director']
    @writer = @movie['Writer']
    @actors = @movie['Actors']
    @plot = @movie['Plot']
    @language = @movie['Language']
    @country = @movie['Country']
    @awards = @movie['Awards']
    @poster = @movie['Poster']
    @imd = @movie['Ratings']
    @metascore = @movie['Metascore']
    @imdb = @movie['imdbRating']
    @box_office = @movie['BoxOffice']
    @production = @movie['Production']
    @website = @movie['Website']
  end

  def consensus
    case @movie["Metascore"].to_i
    when 76..100
      "Two Thumbs Up"
    when 51..75
      "Thumbs Up"
    when 26..50
      "Thumbs Down"
    when 0..25
      "Two Thumbs Down"
    else
      "No rating available"
    end
  end
end

puts "What movie would you like to search?"
movie = Siskel.new(gets.strip)

puts "Title: #{movie.title}"
puts "Year: #{movie.year}"
puts "Rated: #{movie.rating}"
puts "Runtime: #{movie.run_time}"
puts "Genre: #{movie.genre}"
puts "Director: #{movie.director}"
puts "Writer: #{movie.writer}"
puts "Actors: #{movie.actors}"
puts "Plot: #{movie.plot}"
puts "Language: #{movie.language}"
puts "Country: #{movie.country}"
puts "Awards: #{movie.awards}"
puts "Poster: #{movie.poster}"
puts "Ratings: #{movie.imd[0]}"
puts "Metascore: #{movie.metascore}"
puts "IMDB: #{movie.imdb}"
puts "Box Office: #{movie.box_office}"
puts "Production: #{movie.production}"
puts "Website: #{movie.website}"
