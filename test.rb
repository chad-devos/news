
require "forecast_io"
require "geocoder"
ForecastIO.api_key = "b1fa1a3a4bb451b1b1d1f28ef3b4371d"
results = Geocoder.search("paris")
    lat_lng = results.first.coordinates
    lat = lat_lng[0]
    lng = lat_lng[1]
    @forecast = ForecastIO.forecast(lat, lng)
    @current_temperature = @forecast["currently"]["temperature"]
    @current_conditions = @forecast["currently"]["summary"]
    @future_temps = []

    for day in @forecast["daily"]["data"]
        @future_temps << day["temperatureHigh"]
    end
    # puts lat_lng
    # puts @current_temperature
    # puts @current_conditions
    puts @future_temps[0]
