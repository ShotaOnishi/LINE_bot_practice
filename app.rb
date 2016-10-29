require 'sinatra'   # gem 'sinatra'
require 'line/bot'  # gem 'line-bot-api'
require 'json'
require 'rest-client'


module Line
  module Bot
    class HTTPClient
      def http(uri)
        proxy = URI(ENV["FIXIE_URL"])
        http = Net::HTTP.new(uri.host, uri.port, proxy.host, proxy.port, proxy.user, proxy.password)
        if uri.scheme == "https"
          http.use_ssl = true
        end

        http
      end
    end
  end
end

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
  # p events

  events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        if event.message['text'] == "image"
          message = {
            type: "image",
            originalContentUrl: "https://www.google.co.jp/search?q=%E8%97%A4%E7%94%B0%E3%83%8B%E3%82%B3%E3%83%AB&rlz=1C5CHFA_enJP700JP700&espv=2&biw=1275&bih=612&site=webhp&source=lnms&tbm=isch&sa=X&sqi=2&ved=0ahUKEwjR_uaY3f7PAhXLv7wKHRf8AeYQ_AUIBigB#imgrc=bsLd3_ARXaIfrM%3A",
            previewImageUrl: "https://www.google.co.jp/search?q=%E8%97%A4%E7%94%B0%E3%83%8B%E3%82%B3%E3%83%AB&rlz=1C5CHFA_enJP700JP700&espv=2&biw=1275&bih=612&site=webhp&source=lnms&tbm=isch&sa=X&sqi=2&ved=0ahUKEwjR_uaY3f7PAhXLv7wKHRf8AeYQ_AUIBigB#imgrc=bsLd3_ARXaIfrM%3A"
          }
        else
          message = {
            type: 'text',
            text: event.message['text']
          }
        end
        res = client.reply_message(event['replyToken'], message)
        # p res
        #p res.body
      end
    end
  }

  "OK"
end