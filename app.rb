require 'sinatra'   # gem 'sinatra'
require 'line/bot'  # gem 'line-bot-api'
require 'json'
require 'rest-client'
require 'active_record'
require 'pg'

# DB設定ファイルの読み込み
# ActiveRecord::Base.configurations = YAML.load_file('database.yml')
# ActiveRecord::Base.establish_connection('production')

# class Menu < ActiveRecord::Base
# end
require 'require_all'

require_all 'model'

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

# get '/db_test' do
#   content_type :json, :charset => 'utf-8'
#   menus = Menu.order("created_at DESC").limit(2)
#   menus.to_json(:root => false)
# end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  events.each { |event|
    if event.message['text'].include?("画像")
      message = ResponceMessage.new(ImageMessage.new)
    elsif event.message['text'].include?("名言")
      message = ResponceMessage.new(RemarkMessage.new)
    elsif event.message['text'].include?("住所")
      message = ResponceMessage.new(LocationMessage.new)
    elsif event.message['text'].include?("スタンプ")
      message = ResponceMessage.new(StickerMessage.new)
    elsif event.message['text'].include?("イメージリンク")
      message = ResponceMessage.new(ImagemapMessage.new)
    elsif event.message['text'].include?("ボタン")
      message = ResponceMessage.new(ButtonMessage.new)
    elsif event.message['text'].include?("リッチ")
      message = ResponceMessage.new(RichMessage.new)
    elsif event.message['text'].include?("確認")
      message = ResponceMessage.new(ConfirmMessage.new)
    elsif event.message['text'].include?("ミーティング")
      message = ResponceMessage.new(MeetingMessage.new)
    else
      message = ResponceMessage.init_with_event(DefaultMessage.new, event)
    end

    case event.type
      when Line::Bot::Event::MessageType::Text
        res = client.reply_message(event['replyToken'], message.output_message)
        p res
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      else
        p "Noevent"
    end
  }
end

