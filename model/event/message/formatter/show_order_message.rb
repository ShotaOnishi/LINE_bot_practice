class ShowOrderMessage
  def output_message(context)
    {
        "type": "template",
        "altText": "this is a buttons template",
        "template": {
            "type": "buttons",
            #"thumbnailImageUrl": "https://pbs.twimg.com/media/B_QHDbSVEAA1adJ.jpg",
            #"title": "Menu",
            "text": "入店前",
            "actions": [
                {
                    "type": "postback",
                    "label": "丼",
                    "data": "befDON"
                },
                {
                    "type": "postback",
                    "label": "麺類",
                    "data": "befMEN"
                },
                {
                    "type": "postback",
                    "label": "デザート",
                    "data": "befDES"
                }
            ]
        }
    }
  end
end