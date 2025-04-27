# /app.rb

require "sinatra"
require "sinatra/reloader"

# Pull in the HTTP class
require "http"
require "dotenv/load"

# define a route for the homepage
get("/") do

api_key = ENV.fetch("EXCHANGE_KEY")
exchange_url = "https://api.exchangerate.host/list?access_key=#{api_key}"

@raw_response = HTTP.get(exchange_url)

@raw_string = @raw_response.to_s

require "json"

@parsed_data = JSON.parse(@raw_string)

@currencies = @parsed_data.fetch("currencies")


erb(:homepage)

end

get("/:first_symbol") do
  @the_symbol = params.fetch("first_symbol")

  api_key = ENV.fetch("EXCHANGE_KEY")
  exchange_url = "https://api.exchangerate.host/list?access_key=#{api_key}"

  @raw_response = HTTP.get(exchange_url)

@raw_string = @raw_response.to_s

require "json"

@parsed_data = JSON.parse(@raw_string)

@currencies = @parsed_data.fetch("currencies")

  erb(:step_one)

end


# get("/:from_currency") do
#   @original_currency = params.fetch("from_currently")

#   api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_KEY")}"

#   erb(:step_one)

#end

get("/:from_currency/:to_currency") do
  @from = params.fetch("from_currency")
  @to = params.fetch("to_currency")


@api_url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_KEY")}&from=#{@from}&to=#{@to}&amount=1"

@raw_response = HTTP.get(@api_url)

@string_response = @raw_response.to_s

@parsed_response = JSON.parse(@string_response)

@amount = @parsed_response.fetch("result")

erb(:step_two)

end
