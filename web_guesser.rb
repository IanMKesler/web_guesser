require 'sinatra'
require 'sinatra/reloader'

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

get '/' do
    guess = params["guess"].to_i
    response = check_guess(guess - settings.secret_number)
    erb :index, :locals => {:number => settings.secret_number, :response => response}
end