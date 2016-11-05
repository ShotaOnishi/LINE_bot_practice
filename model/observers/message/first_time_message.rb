
class FirstTimeMessage
  def update(changed_callback)
    event = changed_callback.event

    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'first_time'
        Message.reply(event, output)
      end
    elsif Message.is_message?(event)
      Message.reply(event, output)
    end
  end

  def output
    {
        "type": "template",
        "altText": "this is a first time message",
        "template": {
            "type": "buttons",
            "title": "はじめての方へ",
            "text": " 本日は，ご来店ありがとうございます．",
            "actions": [
                {
                    "type": "postback",
                    "label": "もどる",
                    "data": "action=welcome&itemid=123"
                }
            ]
        }
    }
  end
end