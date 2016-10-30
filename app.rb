require 'sinatra'   # gem 'sinatra'
require 'line/bot'  # gem 'line-bot-api'
require 'json'
require 'rest-client'
require 'active_record'
require 'pg'
require 'require_all'
# require 'date'
require_all 'model'

# DB設定ファイルの読み込み
configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  # use Rack::Auth::Basic do |username, password|
  #   username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
  # end
end

configure :development do
  ActiveRecord::Base.configurations = YAML.load_file('database.yml')
  ActiveRecord::Base.establish_connection(:development)
end

class Menu < ActiveRecord::Base
end

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

get '/' do
#   content_type :json, :charset => 'utf-8'
#   menus = Menu.order("created_at DESC").limit(2)
#   menus.to_json(:root => false)
@menus = Menu.all
erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  Menu.create(:name => params[:name],
    :value => params[:value],
    :picture => params[:picture],
    :category => params[:category]
    )
  redirect '/'
end


get '/delete/:id' do
  @menu = Menu.finf(params[:id])
  erb :delete
end

post '/delete/:id' do
  if params.has_key?("ok")
    menu = Menu.find(params[:id])
    menu.destroy
    redirect '/'
  else
    redirect '/'
  end
end



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
        message = ResponceMessage.new(DefaultMessage.new, event)
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

