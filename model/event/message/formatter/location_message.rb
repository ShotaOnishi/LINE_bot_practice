
class LocationMessage
  def output_message(context)
    response_message = "渋谷駅"
    {
        "type": "location",
        "title": response_message,
        "address": "〒150-0002 東京都渋谷区渋谷２丁目２１−１",
        "latitude": 35.65910807942215,
        "longitude": 139.70372892916203
    }
  end
end