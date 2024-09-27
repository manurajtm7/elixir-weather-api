defmodule WeatherApi do
  @api_key "705bd9dafamsh5ecfef5e5d48f32p177420jsn9197cf081c69"
  @base_url "https://weatherapi-com.p.rapidapi.com/current.json?q=53.1%2C-0.13"

  # def get_weather(city) do
  #   url = "#{@base_url}?q=#{city}&appid=#{@api_key}&units=metric"

  #   case HTTPoison.get(url) do
  #     {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
  #       {:ok, Jason.decode!(body)}

  #     {:ok, %HTTPoison.Response{status_code: status_code}} ->
  #       {:error, "Failed to fetch weather data. Status code: #{status_code}"}

  #     {:error, %HTTPoison.Error{reason: reason}} ->
  #       {:error, "HTTP request failed. Reason: #{reason}"}
  #   end
  # end

  def get_weather(city) do
    url = "#{@base_url}?q=#{city}&appid=#{@api_key}&units=metric"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        data = Jason.decode!(body)
        parse_weather_data(data)

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Failed to fetch weather data. Status code: #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "HTTP request failed. Reason: #{reason}"}
    end
  end

  defp parse_weather_data(data) do
    %{
      "main" => %{"temp" => temp, "humidity" => humidity},
      "weather" => [%{"description" => description}]
    } = data

    %{
      temperature: temp,
      humidity: humidity,
      description: description
    }
  end
end
