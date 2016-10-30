
class ImagemapMessage
  def output_message(context)
    {
        "type": "imagemap",
        "baseUrl": ImageMessage.choice_image,
        "altText": "this is an imagemap",
        "baseSize": {
            "height": 1040,
            "width": 1040
        },
        "actions": [
            {
                "type": "uri",
                "linkUri": ImageMessage.choice_image,
                "area": {
                    "x": 0,
                    "y": 0,
                    "width": 520,
                    "height": 1040
                }
            },
            {
                "type": "message",
                "text": "hello",
                "area": {
                    "x": 520,
                    "y": 0,
                    "width": 520,
                    "height": 1040
                }
            }
        ]
    }
  end
end