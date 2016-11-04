
class ConfirmMessage
  def output_message(context)
    {
        "type": "template",
        "altText": "this is a confirm template",
        "template": {
            "type": "confirm",
            "text": "Are you sure?",
            "actions": [
                {
                    "type": "event",
                    "label": "Yes",
                    "text": "yes"
                },
                {
                    "type": "event",
                    "label": "No",
                    "text": "no"
                }
            ]
        }
    }
  end
end