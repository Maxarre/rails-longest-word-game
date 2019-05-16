require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @grid = params[:letters]
    @guess = params[:guess].upcase
    if guess_in_grid
      url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
      result = JSON.parse(open(url).read)
      if result["found"]
        @message = "GG! <strong>#{@guess}</strong> is a valid word."
      else
        @message = "<strong>#{@guess}</strong> does not exist in English... Dumbass!"
      end
    else
      @message = "Really Nigga? From #{@grid.split('').join(', ')} all you did was <strong>#{@guess}</strong>?..."
    end
  end

  def guess_in_grid
    @guess.split.all? do |x|
      @grid.count(x) >= 1 && @guess.count(x) <= @grid.count(x)
    end
  end
end
