
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
                                   

# enter your Dark Sky API key here
ForecastIO.api_key = "b1fa1a3a4bb451b1b1d1f28ef3b4371d"

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=24a8d75cbeb2432da74c0c3f3facfef6"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

# puts "#{news}"
# puts "#{news["articles"][0]["title"]})"
# puts "link: #{news["articles"][0]["url"]}"

@news_headlines=[]
@news_links=[]

 for article in news["articles"]
        @news_headlines << article["title"]
    end

    for article in news["articles"]
        @news_links << article["url"]
    end

    puts "#{@news_headlines[0]}"
    puts "#{@news_links[0]}"
