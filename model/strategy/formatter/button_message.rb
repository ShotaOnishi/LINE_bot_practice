
class ButtonMessage
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
                    "label": "Buy",
                    "data": "action=buy&itemid=123"
                },
                {
                    "type": "postback",
                    "label": "Add to cart",
                    "data": "action=add&itemid=123"
                },
                {
                    "type": "uri",
                    "label": "View detail",
                    "uri": "http://example.com/page/123"
                }
            ]
        }
    }
  end
end