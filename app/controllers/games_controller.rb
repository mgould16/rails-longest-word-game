class GamesController < ApplicationController
require 'json'
require 'open-uri'

  def new
    @letters = Array.new(8) { [*'a'..'z'].sample }
  end


  def score
    @word = params[:new]
    @letters = params[:letters]

    if checkWordInDictionary(@word)
      if checkWordInArray(@word, @letters)
        @answer = "great!"
      else
        @answer = "this word cant be built out of #{@letters}"
      end
    else
      @answer = "This word dosnt exist"
    end

  end

  private

  def checkWordInDictionary(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    return user["found"]
  end

  # def checkWordInArray(word)
  #   array1 = word
  #   array2 = @letters
  #   hash1 = {}
  #   hash2 = {}
  #   array1.each {|l| counts[l] += 1}

  def checkWordInArray(word, letters)
    word.chars.all? { |char| word.chars.count(char) <= letters.count(char) }
  end

end
