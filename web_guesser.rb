require 'sinatra'
require 'sinatra/reloader'

@@guesses = 5

set :secret_number => rand(101)

def check_guess(guess)
    response = guess.abs > 5 ? 'way ' : ''
    if guess > 0
            response += "high"
    elsif guess < 0
            response += "low"   
    elsif guess == 0
            response += "correct"
    end
    response
end

def reset_game
    settings.secret_number = rand(101) 
    @@guesses = 5
end

get '/' do
    guess = params["guess"].to_i
    @@guesses -= 1
    response = check_guess(guess - settings.secret_number)
    if @@guesses == 0
        response = "lost" unless response == "correct"
    end
    reset_game if response == "lost" || response == "correct"
    erb :index, :locals => {:number => settings.secret_number, :response => response, :guesses => @@guesses} #needs to return this!
end