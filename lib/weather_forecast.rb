require 'faraday'
require 'json'

class WeatherForecast

  def initialize(lat, long)
    @response = call_api(lat, long)
  end

  def shorts_weather?
    tomorrows_average_temp >= 18
  end

  private

  def call_api(lat, long)
    weather_api = Faraday.new("https://api.forecast.io/forecast/c957d1bfacf86b27d11f25b5fd8d4c50") do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
    weather_api.get("#{lat},#{long}?units=si")
  end

  def tomorrows_average_temp
    sum_of_temps = 0
    tomorrows_nine_til_five_forecast.each do |forecast|
      sum_of_temps += forecast[:temp]
    end
    sum_of_temps / tomorrows_nine_til_five_forecast.size
  end

  def tomorrows_hourly_forecast
    body = JSON.parse(@response.body)
    tomorrows_hourly_forecast = body['hourly']['data'].map { |hour| get_temp_and_summary(hour) if tomorrow?(Time.at(hour['time'])) }
    tomorrows_hourly_forecast.compact
  end

  def tomorrows_nine_til_five_forecast
      tomorrows_hourly_forecast.find_all { |hour| (hour[:time].hour >= 9) && (hour[:time].hour <= 17) }
  end

  def get_temp_and_summary data
      { temp: data['temperature'], summary: data['summary'], time: Time.at(data['time']) }
  end

  def tomorrow? time
      time.day == Time.now.day + 1
  end

end
