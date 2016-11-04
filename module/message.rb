
module Message
  class << self
    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end

    def reply(event, message)
      if event.is_a?(Line::Bot::Event::Postback)
        client.reply_message(event['replyToken'], message)
      elsif event.is_a?(Line::Bot::Event::Message)
        case event.type
          when Line::Bot::Event::MessageType::Text, Line::Bot::Event::Postback
            res = client.reply_message(event['replyToken'], message)
          when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
            response = client.get_message_content(event.message['id'])
            tf = Tempfile.open("content")
            tf.write(response.body)
          else
            p "Noevent"
        end
      end
    end

    def convert_hash(event)
      q_array = URI::decode_www_form(event['postback']['data'])
      Hash[q_array]
    end

    def is_postback?(event)
      event.is_a?(Line::Bot::Event::Postback)
    end

    def is_message?(event)
      event.is_a?(Line::Bot::Event::Message)
    end

  end
end