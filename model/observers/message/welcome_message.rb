
class WelcomeMessage
  def update(changed_callback)
    event = changed_callback.event

    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'welcome'
        Message.reply(event, output)
      end
    elsif Message.is_message?(event)
      if event.message['text'].include?("ようこそ")
        Message.reply(event, output)
      end
    end
  end

  def output
    {
        'type': "template",
        "altText": 'this is a welcome message',
        "template": {
            "type": 'buttons',
            "text": '御来店ありがとうございます．当店は，LINEによる注文を承っています．以下から，メニュー，ヘルプ，初めての方へのいずれかをお選びください',
            "actions": [
                {
                    "type": "postback",
                    "label": "メニュー",
                    "data": "action=buy&itemid=123"
                },
                {
                    "type": "postback",
                    "label": "本日のおすすめ",
                    "data": "action=buy&itemid=123"
                },
                {
                    "type": "postback",
                    "label": "ヘルプ",
                    "data": "action=help"
                },
                {
                    "type": "postback",
                    "label": "はじめての方へ",
                    "data": "action=first_time"
                }
            ]
        }
    }
  end
end