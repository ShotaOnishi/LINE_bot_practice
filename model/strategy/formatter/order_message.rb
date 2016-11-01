class OrderMessage
  def output_message(context)
    {
        "type": "template",
        "altText": "this is a buttons template",
        "template": {
            "type": "buttons",
            #"thumbnailImageUrl": "https://pbs.twimg.com/media/B_QHDbSVEAA1adJ.jpg",
            #"title": "Menu",
            "text": "Please select",
            "actions": [
                {
                    "type": "postback",
                    "label": "丼",
                    "data": "DON"
                },
                {
                    "type": "postback",
                    "label": "麺類",
                    "data": "MEN"
                },
                {
                    "type": "postback",
                    "label": "デザート",
                    "data": "DES"
                }
            ]
        }
    }
  end
end