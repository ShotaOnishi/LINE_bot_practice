class OrderMessage
  def output_message(context)
    {
        "type": "template",
        "altText": "this is a buttons template",
        "template": {
            "type": "buttons",
            #"thumbnailImageUrl": "https://pbs.twimg.com/media/B_QHDbSVEAA1adJ.jpg",
            #"title": "Menu",
            "text": "入店済",
            "actions": [
                {
                    "type": "postback",
                    "label": "丼",
                    "data": "category=DON"
                },
                {
                    "type": "postback",
                    "label": "麺類",
                    "data": "category=MEN"
                },
                {
                    "type": "postback",
                    "label": "デザート",
                    "data": "category=DES"
                }
            ]
        }
    }
  end
end
