require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "b1fa1a3a4bb451b1b1d1f28ef3b4371d"

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=24a8d75cbeb2432da74c0c3f3facfef6"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output


get "/" do
  view "ask"
end

get "/news" do
    results = Geocoder.search(params["location"])
    lat_lng = results.first.coordinates
    @lat = lat_lng[0]
    @lng = lat_lng[1]
    @forecast = ForecastIO.forecast("#{@lat}","#{@lng}")
    @current_temperature = @forecast["currently"]["temperature"]
    @current_conditions = @forecast["currently"]["summary"]
   
    @future_temps = []
    @future_conditions = []

    @news_headlines = []
    @news_links = []

     for day in @forecast["daily"]["data"]
        @future_temps << day["temperatureHigh"]
    end

    for day in @forecast["daily"]["data"]
        @future_conditions << day["summary"].downcase
    end

    for article in news["articles"]
        @news_headlines << article["title"]
    end

    for article in news["articles"]
        @news_links << article["url"]
    end



     view "news"
end