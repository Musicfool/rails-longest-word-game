require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { Array('A'..'Z').sample }
  end

  def score
    @letters = params[:letters]
    @answer = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    json_file = URI.open(url).read
    wagon_dic = JSON.parse(json_file)
    answer_arr = @answer.upcase.chars

    if !answer_arr.all? { |letter| @letters.include?(letter) }
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{@letters.each_char { |letter| print letter, ','}}."
    elsif wagon_dic['found'] == false
      @result = "Sorry but #{@answer.upcase} does not seem to be a valid English word..."
    elsif answer_arr.sort.all? { |letter| @letters.include?(letter) } && wagon_dic['found'] == false
      @result = "Sorry but #{@answer.upcase} does not seem to be a valid English word..."
    else answer_arr.sort.all? { |letter| @letters.include?(letter) } && wagon_dic['found'] == false
      @result = "Congratulations! #{@answer.upcase} is a valid English word!"
    # compare start_time and end_time
    # give score grid.size points if grid.empty, grid.size - 1 point if grid == 1 etc
    end
  end
end
