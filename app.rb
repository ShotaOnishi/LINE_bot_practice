require 'sinatra'   # gem 'sinatra'
require 'line/bot'  # gem 'line-bot-api'
require 'json'
require 'rest-client'
require 'active_record'
require 'pg'
require 'require_all'
# require 'date'
require_all 'model'
require_all 'module'
include Line

# require 'dotenv'
# Dotenv.load

# Load DB filesDB
configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end

configure :development do
  ActiveRecord::Base.configurations = YAML.load_file('database.yml')
  ActiveRecord::Base.establish_connection(:development)
end

class Menu < ActiveRecord::Base
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
    :price => params[:price],
    :picture => params[:picture],
    :category => params[:category],
    :detall => params[:detail]
    )
  redirect '/'
end


get '/delete/:id' do
  @menu = Menu.find(params[:id])
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
      case event
      when Line::Bot::Event::Postback
        if event["postback"]["data"] == "DON"
          message = ResponceMessage.new(DonMessage.new("丼"))
        elsif event["postback"]["data"] == "MEN"
          message = ResponceMessage.new(DonMessage.new("麺類"))
        elsif event["postback"]["data"] == "DES"
          message = ResponceMessage.new(DonMessage.new("デザート"))
        elsif event["postback"]["data"] == "befDON"
          message = ResponceMessage.new(ShowDonMessage.new("丼"))
        elsif event["postback"]["data"] == "befMEN"
          message = ResponceMessage.new(ShowDonMessage.new("麺類"))
        elsif event["postback"]["data"] == "befDES"
          message = ResponceMessage.new(ShowDonMessage.new("デザート"))
        end
        client.reply_message(event['replyToken'], message.output_message)
      when Line::Bot::Event::Message
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
        elsif event.message['text'].include?("注文")
          mygroup = OrderGroup.find(1)
          if mygroup.enter = true
            message = ResponceMessage.new(OrderMessage.new)
          else
            message = ResponceMessage.new(ShowOrderMessage.new)
          end
        elsif event.message["text"].include?("翻訳")
          message = ResponceMessage.new(TranslateMessage.new, event)
        elsif event.message['text'].include?("入店")
          OrderGroup.create(:enter => true,
                            :start_time => Time.now,
                            :end_time => Time.now + 60*60*2,
                            :table => 1,
                            :user_id => 1
                            )
          message = ResponceMessage.new(DefaultMessage.new, event)
        elsif event.message['text'].include?("退店")
          mygroup = OrderGroup.where(:user_id => 1)
          mygroup.enter = false if mygroup.enter = true
          message = ResponceMessage.new(DefaultMessage.new, event)
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
      end
    }
  end
