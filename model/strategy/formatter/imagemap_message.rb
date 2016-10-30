
class ImagemapMessage
  def output_message(context)
    {
        "type": "imagemap",
        "baseUrl": "https://res.cloudinary.com/hmfnscv52/image/upload/v1475767645/ncsg57zhmhd0zfgqwpq5",
        "altText": "this is an imagemap",
        "baseSize": {
            "height": 1040,
            "width": 1040
        },
        "actions": [
            {
                "type": "uri",
                "linkUri": "https://qiita.com/zakuroishikuro/items/066421bce820e3c73ce9",
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