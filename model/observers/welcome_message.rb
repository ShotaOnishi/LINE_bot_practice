
class WelcomeMessage
  def update(changed_callback)
    event = changed_callback.event

    if event.message['text'].include?("はじめての方へ")
      Reply.reply(event, output)
    end
  end

  def output
    {
        "type": "template",
        "altText": "this is a buttons template",
        "template": {
            "type": "buttons",
            "title": "はじめての方へ",
            "text": " 本日は，ご来店ありがとうございます．",
            "actions": [
                {
                    "type": "postback",
                    "label": "もどる",
                    "data": "action=buy&itemid=123"
                }
            ]
        }
    }
  end
end