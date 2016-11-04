require 'sinatra'   # gem 'sinatra'
require 'line/bot'  # gem 'line-bot-api'
require 'json'
require 'rest-client'
require 'active_record'
require 'pg'
require 'require_all'
require 'uri'
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
  p body
  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  print events
  events = client.parse_events_from(body)

  events.each { |event|
    case event
      when Line::Bot::Event::Postback
        q_array = URI::decode_www_form(event["postback"]['data'])
        q_hash = Hash[q_array]
        message = MessageContext.new(PostbackMessage.new, q_hash)
        client.reply_message(event['replyToken'], message.output_message)
      when Line::Bot::Event::Message
        # puts event.source
        message = MessageContext.new(ResponceMessage.new, event)

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
